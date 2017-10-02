using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

namespace TransitSchedule
{
    public partial class Admin : System.Web.UI.Page
    {
        // TODO: Add A Platform Edit Page - (Grid By Train)
        // SELECT Number, Direction, DepartTime, Platform, Days
        // FROM NextBusDisplay.dbo.StaticTrains
        // WHERE Train = qsTrain -- 'Coaster'

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            var allPlatforms = GetAllPlatformDisplays();

            Table table = new Table();
            table.CssClass = "adminTable";

            TableRow tr = new TableRow();
            table.Rows.Add(tr);

            tr.Cells.Add(new TableCell() { Text = "Route" });
            tr.Cells.Add(new TableCell() { Text = "Stop" });
            tr.Cells.Add(new TableCell() { Text = "Platform" });
            tr.Cells.Add(new TableCell() { Text = "Using NextBus Estimates" });

            foreach (PlatformOverride pd in allPlatforms)
            {
                if (pd.Route == "399") continue; //Skip Sprinter
                tr = new TableRow();
                tr.BackColor = System.Drawing.ColorTranslator.FromHtml( GetAlternateRowColor());
                table.Rows.Add(tr);

                tr.Cells.Add(new TableCell() { Text = pd.Route });
                string stopDescr = "";
                stopDescr = GetPlatformName(pd.Stop);
                tr.Cells.Add(new TableCell() { Text = pd.Stop + " - " + stopDescr });

                //    Old Sprinter Code
                //    pd.Route = 399 - Skip The Dropdown & Display The Checkbox
                //    tr.Cells.Add(new TableCell() { Text = "&nbsp;" });
                //    CheckBox cb = new CheckBox();
                //    cb.Checked = true;
                //    cb.ID = "PlatformOverrideCheckBoxId_" + pd.PlatformOverrideId;
                //    cb.AutoPostBack = true;
                //    if (pd.UseNextBusFeed.HasValue && pd.UseNextBusFeed.Value == false)
                //    {
                //        cb.Checked = false;
                //    }

                //    cb.CheckedChanged += new EventHandler(cb_CheckedChanged);

                //    TableCell cbCell = new TableCell();
                //    cbCell.Controls.Add(cb);
                //    tr.Cells.Add(cbCell);
                //else
                //{
                    // Route 398 Gets The Dropdown And 399 Doesn't
                DropDownList dl = new DropDownList();
                dl.CssClass = "PlatformOverrideDropdown";
                dl.Items.Add("As Scheduled");
                dl.Items.Add("Platform 1");
                dl.Items.Add("Platform 2");
                dl.Items.Add("Platform 3");
                dl.Items.Add("PLATFORM 1");
                dl.Items.Add("PLATFORM 2");
                dl.Items.Add("PLATFORM 3");
                //dl.Items.Add("Platform 3 South");
                //dl.Items.Add("Platform 4 North");
                //dl.Items.Add("Platform 4 South");
                //dl.Items.Add("Platform 5 North");
                //dl.Items.Add("Platform 5 South");
                //dl.Items.Add("Platform 6 North");
                //dl.Items.Add("Platform 6 South");
                //dl.Items.Add("Platform 7 North");
                //dl.Items.Add("Platform 7 South");
                dl.ID = "PlatformOverrideId_" + pd.PlatformOverrideId;
                dl.SelectedIndexChanged += new EventHandler(dl_SelectedIndexChanged);
                dl.AutoPostBack = true;
                TableCell btCell = new TableCell();
                btCell.Controls.Add(dl);
                tr.Cells.Add(btCell);
                dl.SelectedValue = pd.Platform;
                tr.Cells.Add(new TableCell() { Text = "&nbsp;" });
                //}
            }

            this.placeHolder1.Controls.Add(table);
            // this.gridView1.DataSource = this.LinqDataSource1;
            // Add A New Table Of Special Service Notices
            // AutoID, ServiceNoticeID, DisplayText, DisplayFrom, DisplayTo
            var allServiceNotices = GetPlatformServiceNotices();
            // Calendar calendar1 = new Calendar();
            //calendar1.SelectionMode = "DayWeekMonth";
            table = new Table();
            table.CssClass = "adminTable";

            tr = new TableRow();
            table.Rows.Add(tr);

            tr.Cells.Add(new TableCell() { Text = "Edit" });
            tr.Cells.Add(new TableCell() { Text = "Delete" });
            //tr.Cells.Add(new TableCell() { Text = "Service Notice ID" });
            tr.Cells.Add(new TableCell() { Text = "Date&nbsp;From" });
            tr.Cells.Add(new TableCell() { Text = "Date&nbsp;To" });
            TableCell hdCell = new TableCell();
            hdCell.Text = "Display Text";
            Button AddButton = new Button();
            AddButton.Text = "Add";
            AddButton.CommandArgument = "0";
            AddButton.CssClass = "PlatformOverrideDropdown"; //= "submitButton";
            AddButton.Click += new EventHandler(AddButton_Click);
            hdCell.Controls.Add(AddButton);
            tr.Cells.Add(hdCell);
            // tr.Cells.Add(new TableCell() { Text = "Display Text <input type='button' value='Add New' OnClick='ServiceNotice.aspx?Auto=0'>" });
            foreach (ServiceNotices sn in allServiceNotices)
            {
                TableCell btCell = new TableCell();
                tr = new TableRow();
                tr.BackColor = System.Drawing.ColorTranslator.FromHtml(GetAlternateRowColor());
                table.Rows.Add(tr);

                //tr.Cells.Add(new TableCell() { Text = "<input type='button' value='Edit'>" }); 
                btCell = new TableCell();
                // Create a Button object
                Button EditButton = new Button();
                // Set Button properties
                EditButton.Text = "Edit";
                EditButton.CommandArgument = sn.AutoID.ToString();
                EditButton.CssClass = "PlatformOverrideDropdown"; //= "submitButton";
                // Add a Button Click Event handler
                EditButton.Click += new EventHandler(EditButton_Click);
                btCell.Controls.Add(EditButton);
                // tr.Cells.Add(new TableCell() { Text = "<input type='button' value='Delete'>" });
                tr.Cells.Add(btCell);
                btCell = new TableCell();
                // Create a Button object
                Button DeleteButton = new Button();
                // Set Button properties
                DeleteButton.Text = "Delete";
                DeleteButton.CommandArgument = sn.AutoID.ToString();
                DeleteButton.CssClass = "PlatformOverrideDropdown"; //= "submitButton";
                // Add a Button Click Event handler
                DeleteButton.Click += new EventHandler(DeleteButton_Click);
                btCell.Controls.Add(DeleteButton);
                tr.Cells.Add(btCell);
                //tr.Cells.Add(new TableCell() { Text = sn.ServiceNoticeID });

                //calendar1 = new Calendar();
                //calendar1.VisibleDate = sn.DisplayFrom;
                //calendar1.SelectedDate = sn.DisplayFrom;
                //calendar1.CssClass = "CalendarDisplay";
                //TableCell clCell = new TableCell();
                //clCell.Controls.Add(calendar1);
                //tr.Cells.Add(clCell);
                tr.Cells.Add(new TableCell() { Text = sn.DisplayFrom.ToShortDateString() });
                //calendar1 = new Calendar();
                //calendar1.VisibleDate = sn.DisplayTo;
                //calendar1.SelectedDate = sn.DisplayTo;
                //clCell = new TableCell();
                //calendar1.CssClass = "CalendarDisplay";
                //clCell.Controls.Add(calendar1);
                //tr.Cells.Add(clCell);
                tr.Cells.Add(new TableCell() { Text = sn.DisplayTo.ToShortDateString() });
                tr.Cells.Add(new TableCell() { Text = sn.DisplayText });

            }
            this.placeHolder1.Controls.Add(table);
        }

        void cb_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox cb = (CheckBox)sender;

            if (cb.ID.StartsWith("PlatformOverrideCheckBoxId"))
            {
                PlatformOverride po = GetPlatformOverride(int.Parse(cb.ID.Substring(27)));
                po.UseNextBusFeed = cb.Checked;
                // po.OverrideUntil = System.DateTime.Now + NextStopTimeOnThisPlatform;
                dc.SubmitChanges();

            }
        }

        bool altRow = false;
        private string GetAlternateRowColor()
        {
            if (altRow)
            {
                altRow = !altRow;
                return "#005daa";
            }
            else
            {
                altRow = !altRow;
                return "#008c99";
            }

        }

        void dl_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList dl = (DropDownList)sender;

            if (dl.ID.StartsWith("PlatformOverrideId"))
            {
                PlatformOverride po = GetPlatformOverride(int.Parse(dl.ID.Substring(19)));
                po.Platform = dl.SelectedValue;
                // Update The UpdateUntil Value To Be When The Next Departure Time Is Happening.
                Int32 times = GetNextScheduleTime(GetDaysEnumeration());
                po.OverrideUntil = MinutesToDate(times.ToString());
                dc.SubmitChanges();

            }
        }

        DataClasses1DataContext dc = new DataClasses1DataContext();
        private List<PlatformOverride> GetAllPlatformDisplays()
        {

            return (from z in dc.PlatformOverrides
                    orderby z.Route, z.Stop
                    select z).ToList();
        }
        
        private Int32 GetNextScheduleTime(List<string> DaysList)
        {
            // At Most The List Will Have Three Entries At This Time. The GetDaysEnumeration() Is Modified To Always Return The Same Number Of Items
            string[] aDays = DaysList.ToArray();

            // This assumes that the Coaster trains stop before midnight. Sprinter trains go until shortly after midnight.
            // Fix: Add Minutes after midnight to midnight time in DB so 12:01AM = 1441
            // SELECT t.DepartTime FROM StaticTrains t WHERE t.Train = 'Coaster' AND t.Days IN (@tdays) AND CAST(t.DepartTime AS INT) > fn_MinutesSinceMidnight
            try
            {
                var results = (from t in dc.StaticTrains
                               where (t.Train == "Coaster")
                                 && (Convert.ToInt32(t.DepartTime) > MinutesSinceMidnight())
                                 && (t.Days == aDays[0] || t.Days == aDays[1] || t.Days == aDays[2])
                               orderby Convert.ToInt32(t.DepartTime)
                               select Convert.ToInt32(t.DepartTime));
                return results.First(); //.ToList(); //.First().ToString();
            }
            catch
            {
                // Midnight Is An Error - This Time Is An Error
                return 0;
            }
        }

        private List<string> GetDaysEnumeration()
        {
            // Check For Holidays (tbl > 0)
            DataClasses1DataContext dc2 = new DataClasses1DataContext();
            var holiday = (from h in dc2.Holidays
                       where h.Holiday == DateTime.Now
                       select h.Holiday).Count();

            List<string> days = new List<string>();
            if (DateTime.Now.DayOfWeek == DayOfWeek.Monday ||
                DateTime.Now.DayOfWeek == DayOfWeek.Tuesday ||
                DateTime.Now.DayOfWeek == DayOfWeek.Wednesday ||
                DateTime.Now.DayOfWeek == DayOfWeek.Thursday
                )
            {
                days.Add("Weekdays");
                days.Add("Mo-Th");
                days.Add("Mo-Th");
            }
            else if (DateTime.Now.DayOfWeek == DayOfWeek.Friday)
            {
                days.Add("Weekdays");
                days.Add("Fri-Sun");
                days.Add("Friday");
            }
            else if (DateTime.Now.DayOfWeek == DayOfWeek.Saturday)
            {
                days.Add("Weekends");
                days.Add("Fri-Sun");
                days.Add("Saturday");
            }
            else if (DateTime.Now.DayOfWeek == DayOfWeek.Sunday || holiday > 0)
            {
                // Holiday Schedule Is "Sunday" Schedule For Sprinter & Coaster
                days.Add("Weekends");
                days.Add("Fri-Sun");
                days.Add("Sunday");

            }
            return days;
        }
        
        private int MinutesSinceMidnight()
        {
            // Convert The Current Time To Minutes Since Midnight
            // In SQL This Is: DATEDIFF(mi, DATEDIFF(d, 0, GETDATE()), GETDATE())
            DateTime d = DateTime.Now;
            return d.Hour * 60 + d.Minute;
        }

        private DateTime MinutesToDate(string DepartTime)
        {
            // Convert The String DepartTime To The Time Today
            // http://msdn.microsoft.com/en-us/library/bb546099.aspx
            // DepartTime Is A String Integer Of The Minutes Since Midnight
            int iDepart = int.Parse(DepartTime);
            int iHours = iDepart / 60;
            int iMinutes = iDepart % 60;
            DateTime Today = new DateTime(System.DateTime.Today.Year, System.DateTime.Today.Month, System.DateTime.Today.Day, iHours, iMinutes, 0);
            return Today;
        }

        private PlatformOverride GetPlatformOverride(int id)
        {
            // Change This To A Procedure That Updates The Override DateTime?
            var results = from z in dc.PlatformOverrides
                          where z.PlatformOverrideId == id
                          select z;
            return results.First();
        }

        private string GetPlatformName(string StopID)
        {
            // Get The Platform Name In Plain English From The StopDisplay Table
            DataClasses1DataContext dc = new DataClasses1DataContext();
            var results = from s in dc.StopDisplays
                          where s.StopID == StopID
                          select s.Description;
            return results.FirstOrDefault();
        }

        private List<ServiceNotices> GetPlatformServiceNotices()
        {
            // Get All Special Service Notices
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["NextBusDisplayConnectionString"].ConnectionString;
            string strSQL = "SELECT AutoID, ServiceNoticeID, DisplayFrom, DisplayTo, DisplayText FROM dbo.ServiceNotice ORDER BY DisplayFrom, DisplayTo;";
            List<ServiceNotices> results = new List<ServiceNotices>();   // http://forums.asp.net/t/1654695.aspx/1
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(strSQL, connection);
                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    // http://stackoverflow.com/a/8249371/69039     How to convert sqldatareader to list of dto's?
                    // Set Up the Read / Index The Columns
                    int AutoID = reader.GetOrdinal("AutoID");
                    int ServiceNoticeID = reader.GetOrdinal("ServiceNoticeID");
                    int DisplayFrom = reader.GetOrdinal("DisplayFrom");
                    int DisplayTo = reader.GetOrdinal("DisplayTo");
                    int DisplayText = reader.GetOrdinal("DisplayText");

                    // Call Read before accessing data.
                    while (reader.Read())
                    {
                        // Add The Results To The List
                        // http://stackoverflow.com/questions/6042404/how-to-put-values-from-datareader-into-listt
                        var nr = new ServiceNotices();
                        nr.AutoID = reader.GetInt32(AutoID);
                        nr.ServiceNoticeID = reader.GetString(ServiceNoticeID);
                        nr.DisplayFrom = reader.GetDateTime(DisplayFrom);
                        nr.DisplayTo = reader.GetDateTime(DisplayTo);
                        nr.DisplayText = reader.GetString(DisplayText);
                        results.Add(nr);
                    }
                }

                // Call Close when done reading.
                reader.Close();
            }
            // linq failure
            //List<ServiceNotices> results = (from z in dc.ServiceNotices
            //                                orderby z.DisplayFrom, z.DisplayTo
            //                                select z.[0] [1] [2] [3] [4]).ToList();
            //                                //select z.["AutoID"] ["ServiceNoticeID"] ["DisplayFrom"] ["DisplayTo"] ["DisplayText"]).ToList();
            //return results; // ToArray().ToList();
            return results; // ToArray().ToList();
        }

        private void AddButton_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                // Redirect To The Edit Page With No Record ID
                Response.Redirect("ServiceNotice.aspx?Auto=0");
                //string RecID = ((Button)sender).CommandArgument.Trim();
                // Response.Redirect(String.Format("ServiceNotice.aspx?Auto={0}", RecID));
            }
        }
        private void EditButton_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string RecID = ((Button)sender).CommandArgument.Trim();
                Response.Redirect(String.Format("ServiceNotice.aspx?Auto={0}", RecID));
            }
        }
        private void DeleteButton_Click(object sender, EventArgs e)
        {
         if (IsPostBack)
           {
              // This is called if the form has been posted back, possibly by a button click.
               string RecID = ((Button)sender).CommandArgument.Trim();
               // string RecID = ((Button)sender).CommandName;
               if (RecID != "") // Should Only Exist On Click
               {
                   string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["NextBusDisplayConnectionString"].ConnectionString;
                   string strSQL = string.Format("DELETE FROM ServiceNotice WHERE AutoID = {0}", RecID);
                   using (SqlConnection connection = new SqlConnection(connectionString))
                   {
                       SqlCommand command = new SqlCommand(strSQL, connection);
                       connection.Open();
                       command.ExecuteNonQuery();
                   }
                   // Refresh The Screen
                   Response.Redirect("Admin.aspx");
               }
           }            
        }

    }
}
