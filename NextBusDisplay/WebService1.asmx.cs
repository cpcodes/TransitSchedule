using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Util;
using System.Web.Services;
using System.Xml;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Text;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
// For Debug
using System.Diagnostics;

namespace TransitSchedule
{
    /// <summary>
    /// Summary description for WebService1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
    [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {
        static bool isReset = true;

        [WebMethod]
        public bool CheckReset()
        {
            if (isReset)
            {
                isReset = false;
                return true;
            }
            else
            {
                return false;
            }
        }

        [WebMethod]
        public string GetTime()
        {
            return DateTime.Now.ToShortTimeString();
        }

        [WebMethod]
        public string FetchSchedule(string queryString) // From AJAX in Default.aspx
        {
            BuildScheduleFromQueryString(queryString);

            DataClasses1DataContext dc1 = new DataClasses1DataContext();

            string content = UpdateScheduleTimes();

            string returnData = $"<tbody>{content}</tbody>";
            return @returnData;
        }

        private string UpdateScheduleTimes()
        {
            int minuteNow = (DateTime.Now.Hour * 60) + DateTime.Now.Minute;
            List<string> days = GetDaysEnumeration();
            StringBuilder sb = new StringBuilder();

            // If today's date exists in the Holiday table (count=1) then today is a holiday.
            DataClasses1DataContext dc2 = new DataClasses1DataContext();
            var tbl = (from h in dc2.Holidays
                       where h.Holiday == DateTime.Now
                       select h.Holiday).Count();

            bool isHoliday = tbl > 0 ? true : false;
            dc2.Dispose();

            List<PlatformOverride> overrides = GetAllPlatformOverrides();    // Load The Platform Override Data From The Database

            foreach (Schedule schedule in schedules)
            {
                schedule.DepartureMessage = "Scheduled Departure Time";

                //schedule.DebugMessage = string.Empty;
                schedule.isDelayed = false;
                // schedule.Direction = string.Empty;

                // TODO redo this using a table lookup rather than a nested iteration
                 if (overrides != null)
                {
                    foreach (PlatformOverride po in overrides)
                    {
                        if (schedule.Route == po.Route && schedule.Stop.ToString() == po.Stop.ToString())
                        {
                            if (po.Platform != "As Scheduled") // Consolidate into single if statement or keep in case I want to check for po.Departure?
                            {
                                schedule.Platform = po.Platform;
                            }
                            // TODO once we allow update of time in Overrides, put if statement here to set schedule.isDelayed to true
                        }
                    }
                }

                // TODO Since Amtrak and Metrolink are exceptions to a number of rules, maybe set this up as a gate clause for multiple rules and avoid DB hits.
                if (isHoliday && (schedule.Route.ToLower() != "amtrak" && schedule.Route.ToLower() != "metrolink"))
                {
                    schedule.DebugMessage = schedule.DebugMessage + " Holiday";
                    days = new List<string>();
                    days.Add("Weekends");
                    days.Add("Fri-Sun");
                    days.Add("Sunday");
                }

                // There is no concept of being delayed - PlatformOverride only accounts for changes in platform, not departure time
                if (schedule.isDelayed) 
                {
                    schedule.DepartureMessage = "Adjusted Departure Time";
                }

                sb.Append(CreateScheduleRow(schedule));
            }

            return sb.ToString();
        }

        private string CreateScheduleRow(Schedule schedule)
        {
            string timeStyle = schedule.isDelayed ? "Delayed" : "OnTime";

            return
            //    $@"<div class=""ScheduleRow"">
            //        <div>
            //            <img src=""./Content/Images/{schedule.Logo}"" />
            //            <span class=""LogoMessage"">&nbsp;{schedule.LogoMessage}</span>
            //            <div class=""StopTitle"">{schedule.StopTitle} to {schedule.Direction}</div>
            //        </div>
            //        <div>
            //            <div id=""divDeparture-@alt"" class=""{timeStyle}"" >{schedule.Departure}</div>
            //            <div id=""divDepartureMsg-@alt"" class=""DepartureMessage"">{schedule.DepartureMessage}</div>
            //        </div>
            //        <div class=""Platform"">{schedule.Platform}</div>
            //    </div>";
            $@"<tr>
                        <td>                            
                            <div>
                                <img src=""./Content/Images/{schedule.Logo}"" />
                                <span class=""LogoMessage"">&nbsp;{schedule.LogoMessage}</span>
                            </div>                       
                            <div class=""StopTitle"">{schedule.StopTitle} to {schedule.Direction}</div>
                        </td>
                        <td>
                            <div id=""divDeparture-@alt"" class=""{timeStyle}"" >{GetTimeString(schedule.Departure)}</div>
                            <div id=""divDepartureMsg-@alt"" class=""DepartureMessage"">{schedule.DepartureMessage}</div>
                        </td>
                        <td>
                            <div class=""Platform"">{schedule.Platform}</div>
                        </td>
                    </tr>";
        }

        private List<Schedule> schedules;

        // TODO Much prefer represnting time as hours*100 + minutes. Will adjust later
        private string GetTimeString(string MidnightMinutes)
        {
            // This is designed for output minutes so that any calculations can be done more easily
            // Get Short Time String From Minutes Since Midnight
            bool isNumeric = int.TryParse(MidnightMinutes, out int Minutes);
            if (isNumeric)
            { return DateTime.Today.AddMinutes(Minutes).ToShortTimeString(); }
            else
            {
                // If Not Numeric - Return The Input String
                return MidnightMinutes;
            }
        }

        private void BuildScheduleFromQueryString(string stops)
        {
            // This Is Where Any Special Split Would Happen To Handle The Special ServiceNoticeID
            // TODO - Add The Special ServiceNoticeID Indicator.
            // Stops Is The "QueryString"
            stops = stops.Replace("stops=", "");

            schedules = new List<Schedule>();

            foreach (string stop in stops.Split('-'))
            {
                Schedule schedule;
                Schedule schedule2;
                string route = "";
                string stopId = "";
                if (stop.Contains(','))
                {
                    route = stop.Split(',')[0];
                    stopId = stop.Split(',')[1];
                }
                else
                {
                    route = stop;
                }

                string routeUpper = route.ToUpper();
                if (routeUpper == null)
                {
                    // do nothing
                }
                else if (routeUpper == "399")
                {
                    schedule = new Schedule();
                    schedule.Route = route;
                    schedule.Stop = stopId;
                    schedule.Agency = "nctd";
                    schedule.Logo = "sprinter-logo.png";
                    // TODO Add Sprinter & Coaster North / Southbound Messages ???? schedule.Direction = "Oceanside" / "San Diego" / "Escondido" -- Not Now Amtrack Only
                    schedule.LogoMessage = "";
                    schedule.LogoStyle = "width:23em";
                    schedule.RouteType = Schedule.RouteTypes.Sprinter;
                    // Last Stop (Escondido) Reverse Direction
                    if (stopId == "27014" || stopId == "27014_ar")
                    {
                        schedule.Direction = "Oceanside";
                    }
                    else
                    {
                        schedule.Direction = "Escondido";
                    }
                    schedule.StopTitle = "Oceanside Transit Center";
                    schedule.useNextBusEstimate = true;
                    schedule.useNextBusEstimate2 = true;
                    //schedule.DebugMessage = " true";
                    schedule.ScheduleId2 = "";
                    // Get Next 2 Scheduled Times For This Stop
                    GetStaticSchedule(schedule);
                    schedules.Add(schedule);

                    // Not An Endpoint Add A Schedule For The Opposite Direction
                    if (stopId != "27000" && stopId != "27000_ar" && stopId != "27014" && stopId != "27014_ar")
                    {
                        schedule = new Schedule();
                        schedule.Route = route;
                        schedule.Stop = stopId;
                        schedule.RouteType = Schedule.RouteTypes.Sprinter;
                        schedule.Agency = "nctd";
                        schedule.Logo = "sprinter-logo.png";
                        schedule.LogoMessage = "";
                        schedule.Direction = "Oceanside";
                        schedule.LogoStyle = "width:23em";
                        schedule.StopTitle = "Oceanside Transit Center";
                        //schedule.DebugMessage = " true";
                        schedule.useNextBusEstimate = true;
                        schedule.ScheduleId2 = "";
                        schedule.useNextBusEstimate2 = true;
                        GetStaticSchedule(schedule);
                        schedules.Add(schedule);
                    }
                }
                else if (routeUpper == "398")
                {
                    schedule = new Schedule();
                    schedule.Route = route;
                    schedule.Stop = stopId;
                    schedule.RouteType = Schedule.RouteTypes.Coaster;
                    schedule.Agency = "nctd";
                    schedule.Logo = "coaster-logo.png";
                    schedule.LogoMessage = "";
                    // Last Stop Reverse Direction
                    if (stopId == "28007" || stopId == "28007_ar")
                    {
                        schedule.Direction = "Oceanside";
                    }
                    else
                    {
                        schedule.Direction = "San Diego";
                    }
                    schedule.LogoStyle = "width:23em";
                    //schedule.DebugMessage = " true";
                    schedule.useNextBusEstimate = true;
                    schedule.useNextBusEstimate2 = true;
                    schedule.ScheduleId2 = "";
                    GetStaticSchedule(schedule);
                    schedules.Add(schedule);
                    // Not An Endpoint Get The Opposite Direction
                    if (stopId != "28000" && stopId != "28007" && stopId != "28000_ar" && stopId != "28007_ar")
                    {
                        schedule2 = new Schedule();
                        schedule2.Route = route;
                        schedule2.Stop = stopId;
                        schedule2.RouteType = Schedule.RouteTypes.Coaster;
                        schedule2.Agency = "nctd";
                        schedule2.Logo = "coaster-logo.png";
                        schedule2.LogoMessage = "";
                        // schedule.Direction = "";
                        schedule2.Direction = "Oceanside";
                        schedule.StopTitle = "Oceanside Transit Center";
                        schedule2.LogoStyle = "width:23em";
                        schedule2.DebugMessage = " true";
                        schedule2.useNextBusEstimate = true;
                        schedule2.useNextBusEstimate2 = true;
                        schedule.ScheduleId2 = "";
                        GetStaticSchedule(schedule2);
                        schedules.Add(schedule2);
                    }
                }
                else if (routeUpper == "METROLINK")
                {
                    schedule = new Schedule();
                    schedule.Route = route;
                    schedule.Stop = stopId;
                    schedule.RouteType = Schedule.RouteTypes.Metrolink;
                    schedule.Agency = "metrolink";
                    schedule.Logo = "metrolink-logo.png";
                    schedule.LogoMessage = "";
                    schedule.LogoStyle = "width:23em";
                    //schedule.DebugMessage = " false";
                    schedule.Direction = "North Bound";
                    schedule.StopTitle = "Oceanside Transit Center";
                    schedule.useNextBusEstimate = false;
                    schedule.useNextBusEstimate2 = true;
                    schedule.ScheduleId = "";
                    GetStaticScheduleExternal(schedule);
                    // Turn Off the Second Schedule
                    schedule.Departure2 = "Tomorrow";
                    schedule.Arrival2 = "Tomorrow";
                    schedules.Add(schedule);
                }
                else if (routeUpper == "AMTRAK")
                {
                    schedule = new Schedule();
                    schedule.Route = route;
                    schedule.Stop = stopId;
                    schedule.RouteType = Schedule.RouteTypes.Amtrak;
                    schedule.Agency = "amtrak";
                    schedule.Logo = "amtrak-logo-nb.png";
                    schedule.LogoMessage = "";
                    schedule.Direction = "North Bound";
                    schedule.LogoStyle = "width:23em";
                    schedule.StopTitle = "Oceanside Transit Center";
                    //schedule.DebugMessage = " false";
                    schedule.useNextBusEstimate = false;
                    schedule.useNextBusEstimate2 = false;
                    schedule.ScheduleId = "";
                    GetStaticScheduleExternal(schedule);
                    // Turn Off the Second Schedule
                    schedule.Departure2 = "Tomorrow";
                    schedule.Arrival2 = "Tomorrow";
                    schedules.Add(schedule);

                    schedule = new Schedule();
                    schedule.Route = route;
                    schedule.Stop = stopId;
                    schedule.RouteType = Schedule.RouteTypes.Amtrak;
                    schedule.Agency = "amtrak";
                    schedule.Logo = "amtrak-logo-sb.png";
                    schedule.LogoMessage = "";
                    schedule.Direction = "South Bound";
                    schedule.StopTitle = "Oceanside Transit Center";
                    schedule.LogoStyle = "width:23em";
                    //schedule.DebugMessage = " false";
                    schedule.useNextBusEstimate = false;
                    schedule.useNextBusEstimate2 = false;
                    schedule.ScheduleId = "";
                    GetStaticScheduleExternal(schedule);
                    // Turn Off the Second Schedule
                    schedule.Departure2 = "Tomorrow";
                    schedule.Arrival2 = "Tomorrow";
                    schedules.Add(schedule);
                }
                else if (routeUpper == "301")
                {
                    schedule = new Schedule();
                    schedule.Route = route;
                    schedule.Stop = stopId;
                    schedule.RouteType = Schedule.RouteTypes.Breeze;
                    schedule.Agency = "nctd";
                    schedule.Logo = "breeze-logo.png";
                    schedule.LogoMessage = " 101";
                    schedule.LogoStyle = "width:17em";
                    schedule.Direction = "Oceanside";
                    if (schedule.Stop == "92125")
                    {
                        schedule.Direction = "VA / UTC";
                    }
                    //schedule.DebugMessage = " false";
                    schedule.useNextBusEstimate = false;
                    schedule.useNextBusEstimate2 = false;
                    schedule.ScheduleId2 = "";
                    GetStaticSchedule(schedule);
                    // Turn Off the Second Schedule
                    schedule.Departure2 = "Tomorrow";
                    schedule.Arrival2 = "Tomorrow";
                    schedules.Add(schedule);
                }
                else if (routeUpper == "302")
                {
                    // Breeze To Oceanside
                    schedule = new Schedule();
                    schedule.Route = route;
                    schedule.Stop = stopId;
                    schedule.RouteType = Schedule.RouteTypes.Breeze;
                    schedule.Agency = "nctd";
                    schedule.Logo = "breeze-logo.png";
                    schedule.LogoMessage = " " + route;
                    schedule.LogoStyle = "width:17em";
                    schedule.Direction = "Oceanside";
                    // 92132 Oceanside Transit Center
                    if (schedule.Stop == "92126")
                    {
                        schedule.Direction = "Vista";
                    }
                    //schedule.DebugMessage = " false";
                    schedule.useNextBusEstimate = true;
                    schedule.useNextBusEstimate2 = true;
                    schedule.ScheduleId2 = "";
                    GetStaticSchedule(schedule);
                    // Turn Off the Second Schedule
                    schedule.Departure2 = "Tomorrow";
                    schedule.Arrival2 = "Tomorrow";
                    schedules.Add(schedule);
                }
                else if (routeUpper == "303")
                {
                    // Breeze To Oceanside
                    schedule = new Schedule();
                    schedule.Route = route;
                    schedule.Stop = stopId;
                    schedule.RouteType = Schedule.RouteTypes.Breeze;
                    schedule.Agency = "nctd";
                    schedule.Logo = "breeze-logo.png";
                    schedule.LogoMessage = " " + route;
                    schedule.LogoStyle = "width:17em";
                    schedule.Direction = "Oceanside";
                    // 92132 Oceanside Transit Center
                    if (schedule.Stop == "92127")
                    {
                        schedule.Direction = "Vista";
                    }
                    //schedule.DebugMessage = " false";
                    schedule.useNextBusEstimate = true;
                    schedule.useNextBusEstimate2 = true;
                    schedule.ScheduleId2 = "";
                    GetStaticSchedule(schedule);
                    // Turn Off the Second Schedule
                    schedule.Departure2 = "Tomorrow";
                    schedule.Arrival2 = "Tomorrow";
                    schedules.Add(schedule);
                }
                else if (routeUpper == "313")
                {
                    // Breeze To Oceanside
                    schedule = new Schedule();
                    schedule.Route = route;
                    schedule.Stop = stopId;
                    schedule.RouteType = Schedule.RouteTypes.Breeze;
                    schedule.Agency = "nctd";
                    schedule.Logo = "breeze-logo.png";
                    schedule.LogoMessage = " " + route;
                    schedule.LogoStyle = "width:17em";
                    schedule.Direction = "Oceanside";
                    // 92132 Oceanside Transit Center
                    if (schedule.Stop == "92131")
                    {
                        schedule.Direction = "Town Center North";
                    }
                    //schedule.DebugMessage = " false";
                    schedule.useNextBusEstimate = true;
                    schedule.useNextBusEstimate2 = true;
                    schedule.ScheduleId2 = "";
                    GetStaticSchedule(schedule);
                    // Turn Off the Second Schedule
                    schedule.Departure2 = "Tomorrow";
                    schedule.Arrival2 = "Tomorrow";
                    schedules.Add(schedule);
                }
                else if (routeUpper == "318")
                {
                    // Breeze To Oceanside
                    schedule = new Schedule();
                    schedule.Route = route;
                    schedule.Stop = stopId;
                    schedule.RouteType = Schedule.RouteTypes.Breeze;
                    schedule.Agency = "nctd";
                    schedule.Logo = "breeze-logo.png";
                    schedule.LogoMessage = " 318";
                    schedule.LogoStyle = "width:17em";
                    schedule.Direction = "Oceanside";
                    // 92132 Oceanside Transit Center
                    if (schedule.Stop == "22941" || schedule.Stop == "92132")
                    {
                        schedule.Direction = "Vista";
                    }
                    //schedule.DebugMessage = " false";
                    schedule.useNextBusEstimate = true;
                    schedule.useNextBusEstimate2 = true;
                    schedule.ScheduleId2 = "";
                    GetStaticSchedule(schedule);
                    // Turn Off the Second Schedule
                    schedule.Departure2 = "Tomorrow";
                    schedule.Arrival2 = "Tomorrow";
                    schedules.Add(schedule);
                }
                else if (routeUpper == "395")
                {
                    // Breeze To Oceanside
                    schedule = new Schedule();
                    schedule.Route = route;
                    schedule.Stop = stopId;
                    schedule.RouteType = Schedule.RouteTypes.Breeze;
                    schedule.Agency = "nctd";
                    schedule.Logo = "breeze-logo.png";
                    schedule.LogoMessage = " " + route;
                    schedule.LogoStyle = "width:17em";
                    schedule.Direction = "Oceanside";
                    // 92132 Oceanside Transit Center
                    if (schedule.Stop == "92133")
                    {
                        schedule.Direction = "San Clemente";
                    }
                    //schedule.DebugMessage = " false";
                    schedule.useNextBusEstimate = true;
                    schedule.useNextBusEstimate2 = true;
                    schedule.ScheduleId2 = "";
                    GetStaticSchedule(schedule);
                    // Turn Off the Second Schedule
                    schedule.Departure2 = "Tomorrow";
                    schedule.Arrival2 = "Tomorrow";
                    schedules.Add(schedule);
                }
                else
                {
                    schedule = new Schedule();
                    schedule.Route = route;
                    schedule.Stop = stopId;
                    schedule.RouteType = Schedule.RouteTypes.Breeze;
                    schedule.Agency = "nctd";
                    schedule.Logo = "breeze-logo.png";
                    schedule.LogoMessage = " " + schedule.Route;
                    schedule.LogoStyle = "width:17em";
                    schedule.Direction = "";
                    //schedule.DebugMessage = " true";
                    schedule.useNextBusEstimate = true;
                    schedule.useNextBusEstimate2 = true;
                    schedule.ScheduleId2 = "";
                    GetStaticSchedule(schedule);
                    schedules.Add(schedule);
                }
            }
        }

        private void GetStaticSchedule(Schedule schedule)
        {
            // For Sprinter And Coaster
            // By Default The Values Will Always Be Schedule Estimated Times Will Override The Schedule
            // All times in the database are departure times - Calculate The Arrival Time Based On A Slow Load
            // NOTE: Datafeed  epochTime Is In Milliseconds - Use Left(epochTime, 10) To Calculate UTCTime
            int LayoverMinutes = int.Parse(System.Configuration.ConfigurationManager.AppSettings["LayoverMinutes"]); // -5
            List<string> days = GetDaysEnumeration();
            int minuteNow = (DateTime.Now.Hour * 60) + DateTime.Now.Minute;
            DataClasses1DataContext dc1 = new DataClasses1DataContext();

            // By Default Everything Is Tomorrow
            schedule.Departure = "Tomorrow";
            schedule.Departure2 = "Tomorrow";
            schedule.Arrival = "Tomorrow";
            schedule.Arrival2 = "Tomorrow";
            var staticTrains = (from x in dc1.StaticTrains
                                where x.TrainID == schedule.Route.ToLower()
                                    && Convert.ToInt32(x.DepartTime) >= minuteNow
                                    && x.Direction == schedule.Direction
                                    && x.StopID == schedule.Stop
                                    && days.Contains(x.Days)
                                orderby Convert.ToInt32(x.DepartTime) ascending
                                select x).Take(1); // Taking one but keeping Take rather than FirstOrDefault in case we decide to go back to keeping 2
            //  join t In dc1.StopDisplay on x.StopID == t.StopID
            //                                  && x.Direction.Contains(schedule.Direction)
            //                                  && x.StopID.Contains(schedule.Stop)
            //where x.Train == schedule.RouteType.ToString()

            // Dump The Resulting SQL (Doesn't Work)
            // ((ObjectQuery)staticTrains).ToTraceString().Dump("--Linq Query"); // From http://visualstudiomagazine.com/blogs/tool-tracker/2011/11/seeing-the-sql.aspx

            // Using this structure because C# Can't Do Multiple Indexers & Can't Do Arrays In A Class
            bool isFirst = true;
            if (staticTrains.Count() > 0)
            {
                //staticTrains.Take(2);
                foreach (StaticTrain statictrain in staticTrains)
                {
                    if (isFirst)
                    {
                        // schedule.StopTitle = statictrain.StopTitle
                        schedule.Platform = statictrain.Platform;
                        // Calculate The Arrival Time From The Departure Time In The DB (If It Exists) - Shouldn't get here if no trains available
                        //schedule.Departure = (DateTime.Parse(DateTime.Now.ToShortDateString()).AddMinutes(Convert.ToInt32(statictrain.DepartTime))).ToShortTimeString();
                        schedule.Departure = statictrain.DepartTime;
                        // schedule.Arrival = (Convert.ToDateTime(schedule.Departure).AddMinutes(LayoverMinutes)).ToShortTimeString();
                        schedule.Arrival = (int.Parse(schedule.Departure) + LayoverMinutes).ToString();
                        schedule.ScheduleId = statictrain.StaticTrainId.ToString();
                        schedule.blockid = statictrain.BlockID;
                        isFirst = false;
                    }
                    else
                    {
                        // Calculate The Arrival Time From The Departure Time In The DB (If It Exists) - Shouldn't get here if no trains available
                        // And Will Get Here Once Because Of .Take(2) Limit
                        //schedule.Departure2 = (DateTime.Parse(DateTime.Now.ToShortDateString()).AddMinutes(Convert.ToInt32(statictrain.DepartTime))).ToShortTimeString();
                        //schedule.Arrival2 = (Convert.ToDateTime(schedule.Departure2).AddMinutes(LayoverMinutes)).ToShortTimeString();
                        schedule.Platform2 = statictrain.Platform;
                        schedule.Departure2 = statictrain.DepartTime;
                        schedule.Arrival2 = (int.Parse(schedule.Departure2) + LayoverMinutes).ToString();
                        schedule.ScheduleId2 = statictrain.StaticTrainId.ToString();
                        schedule.blockid2 = statictrain.BlockID;
                    }
                    
                }
            }
            // Get The Stop Description From The Database
            try
            {
                var Stop_Title = (from x in dc1.StopDisplays
                                  where x.StopID == schedule.Stop
                                  select x.Description).First();
                schedule.StopTitle = Stop_Title;
                // Remove The Line Name For Sprinter & Coaster
                if (schedule.RouteType == Schedule.RouteTypes.Coaster || schedule.RouteType == Schedule.RouteTypes.Sprinter)
                {
                    schedule.StopTitle = schedule.StopTitle.Substring(schedule.StopTitle.IndexOf(' ') + 1);
                }
            }
            catch
            {
                schedule.StopTitle = schedule.Stop;
            }
            // Debug.Print(schedule.Route + " - " + schedule.RouteType.ToString() + " - " + schedule.Direction + " - " + schedule.Stop + " - " + schedule.StopTitle);
        }

        private void GetStaticScheduleExternal(Schedule schedule)
        {
            // By Default The Values Will Always Be Schedule Estimated Times Will Override The Schedule
            // All times in the database are departure times - Calculate The Arrival Time Based On A Slow Load
            // NOTE: Datafeed  epochTime Is In Milliseconds - Use Left(epochTime, 10) To Calculate UTCTime
            int LayoverMinutes = int.Parse(System.Configuration.ConfigurationManager.AppSettings["LayoverMinutes"]); // -5
            List<string> days = GetDaysEnumeration();
            int minuteNow = (DateTime.Now.Hour * 60) + DateTime.Now.Minute;
            DataClasses1DataContext dc1 = new DataClasses1DataContext();

            // By Default Everything Is Tomorrow
            schedule.Departure = "Tomorrow";
            schedule.Departure2 = "Tomorrow";
            schedule.Arrival = "Tomorrow";
            schedule.Arrival2 = "Tomorrow";
            var staticTrains = (from x in dc1.StaticTrains
                                where x.Train == schedule.Route.ToString()
                                    && Convert.ToInt32(x.DepartTime) >= minuteNow
                                    && (x.Direction == schedule.Direction || x.Direction == "")
                                    //&& x.StopID == schedule.Stop
                                    && days.Contains(x.Days)
                                orderby Convert.ToInt32(x.DepartTime) ascending
                                select x).Take(2);
            // Using this structure because C# Can't Do Multiple Indexers & Can't Do Arrays In A Class
            bool isFirst = true;
            if (staticTrains.Count() > 0)
            {
                //staticTrains.Take(2);
                foreach (StaticTrain statictrain in staticTrains)
                {
                    if (isFirst)
                    {
                        // Calculate The Arrival Time From The Departure Time In The DB (If It Exists) - Shouldn't get here if no trains available
                        //schedule.Departure = (DateTime.Parse(DateTime.Now.ToShortDateString()).AddMinutes(Convert.ToInt32(statictrain.DepartTime))).ToShortTimeString();
                        schedule.Departure = statictrain.DepartTime;
                        // schedule.Arrival = (Convert.ToDateTime(schedule.Departure).AddMinutes(LayoverMinutes)).ToShortTimeString();
                        schedule.Arrival = (int.Parse(schedule.Departure) + LayoverMinutes).ToString();
                        schedule.Platform = statictrain.Platform;
                        isFirst = false;
                    }
                    else
                    {
                        // Calculate The Arrival Time From The Departure Time In The DB (If It Exists) - Shouldn't get here if no trains available
                        //schedule.Departure2 = (DateTime.Parse(DateTime.Now.ToShortDateString()).AddMinutes(Convert.ToInt32(statictrain.DepartTime))).ToShortTimeString();
                        //schedule.Arrival2 = (Convert.ToDateTime(schedule.Departure2).AddMinutes(LayoverMinutes)).ToShortTimeString();
                        schedule.Departure2 = statictrain.DepartTime;
                        schedule.Arrival2 = (int.Parse(schedule.Departure2) + LayoverMinutes).ToString();
                        schedule.Platform2 = statictrain.Platform;
                    }
                    
                }
            }
        }

        private List<string> GetDaysEnumeration() // TODO Should probably update DB to store a bit field or comma seperated list for the days
        {
            List<string> days = new List<string>();
            // Added enumerated days to prepare for auto download from NextBus - Each Day Will Be Enumerated By Itself
            if (DateTime.Now.DayOfWeek == DayOfWeek.Monday)
            {
                days.Add("Monday");
                days.Add("Weekdays");
                days.Add("Mo-Th");
            }
            else if (DateTime.Now.DayOfWeek == DayOfWeek.Tuesday)
            {
                days.Add("Tuesday");
                days.Add("Weekdays");
                days.Add("Mo-Th");
            }
            else if (DateTime.Now.DayOfWeek == DayOfWeek.Wednesday)
            {
                days.Add("Wednesday");
                days.Add("Weekdays");
                days.Add("Mo-Th");
            }
            else if (DateTime.Now.DayOfWeek == DayOfWeek.Thursday)
            {
                days.Add("Thursday");
                days.Add("Weekdays");
                days.Add("Mo-Th");
            }
            else if (DateTime.Now.DayOfWeek == DayOfWeek.Friday)
            {
                days.Add("Friday");
                days.Add("Weekdays");
                days.Add("Fri-Sun");
            }
            else if (DateTime.Now.DayOfWeek == DayOfWeek.Saturday)
            {
                days.Add("Saturday");
                days.Add("Weekends");
                days.Add("Fri-Sun");
            }
            else if (DateTime.Now.DayOfWeek == DayOfWeek.Sunday)
            {
                days.Add("Sunday");
                days.Add("Weekends");
                days.Add("Fri-Sun");
            }
            return days;
        }

        private List<PlatformOverride> GetAllPlatformOverrides()
        {
            var results = new List<PlatformOverride>();
            DataClasses1DataContext dc = new DataClasses1DataContext();
            try
            {
                //var results = from z in dc.PlatformOverrides
                //              orderby z.Route
                //              select z;
                //return results.ToList();
                // sp_PlatformOverride Contains All Of The Linq Above And An Update To Auto-Turn-Off The Platform Override
                // sp_platformOverride auto-turn-off:
                // UPDATE PlatformOverride SET Platform = 'As Scheduled'
                // WHERE[Platform] <> 'As Scheduled'
                //  AND GETDATE() > OverrideUntil
                // TODO I'd much prefer to delete the row, but I'm not yet sure what would break
                results = dc.sp_PlatformOverride().ToList();
            }
            catch
            {
                
            }
            finally
            {
                dc.Dispose();
            }
            return results.ToList();
        }

        private string GetPlatformServiceNotice(string id)
        {
            // Special Service Notices - Only The Top 1 Is Selected
            // No ID Means All Locations
            // TODO rewrite as LINQ
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["NextBusDisplayConnectionString"].ConnectionString;
            string strSQL = "SELECT TOP 1 DisplayText FROM dbo.ServiceNotice " +
                             "WHERE (DisplayFrom <= GETDATE() AND DisplayTo >= CONVERT(date, GETDATE())) " +
                             "ORDER BY DisplayFrom, DisplayTo;";

            if (id != "")
            {
                strSQL = "SELECT TOP 1 DisplayText FROM dbo.ServiceNotice " +
                         "WHERE (DisplayFrom <= GETDATE() AND DisplayTo >= CONVERT(date, GETDATE())) " +
                         "  AND ServiceNoticeID IN ('" + id.Trim() + "', '') " +
                         "ORDER BY ServiceNoticeID, DisplayFrom, DisplayTo;";
            }
            string returnValue = "";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(strSQL, connection);
                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    reader.Read();
                    returnValue = reader["DisplayText"].ToString();
                }
                // Call Close when done reading.
                reader.Close();
            }
            //DataClasses1DataContext dc = new DataClasses1DataContext();
            //DateTime now = DateTime.Now;
            //returnValue = dc.ServiceNotices
            //    .Where(sn => sn.DisplayFrom<=now && sn.DisplayTo>=now && sn.ServiceNoticeID==id.Trim())
            //    .OrderBy(sn => sn.ServiceNoticeID)
            //    .ThenBy(sn => sn.DisplayFrom)
            //    .ThenBy(sn => sn.DisplayTo)
            //    .FirstOrDefault()
            //    .DisplayText
            //    .ToString();

            //dc.Dispose();

            // Return The Text Converting The Plain Text To HTML
            return returnValue.Replace("\r\n", "<br />");
            // linq version
            //DataClasses1DataContext dc = new DataClasses1DataContext();
            //var results = (from z in dc.ServiceNotices
            //               where (z.ServiceNoticeID == id || z.ServiceNoticeID == "")
            //                  && (z.DisplayFrom >= System.DateTime.Now && z.DisplayTo <= System.DateTime.Now)
            //               select z.DisplayText).First();
            //    return results.ToString();
        }

        private Boolean IsNumeric(string stringToTest)
        {
            int result;
            return int.TryParse(stringToTest, out result);
            
        }
    }
}
