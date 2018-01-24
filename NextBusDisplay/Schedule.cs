using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TransitSchedule
{
    public class Schedule
    {
        public enum RouteTypes
        {
            Sprinter,
            Coaster,
            Metrolink,
            Amtrak,
            Breeze
        }

        private RouteTypes routeType;
        public RouteTypes RouteType
        {
            get { return routeType; }
            set { routeType = value; }
        }

        string route;               // The Route Number
        public string Route
        {
            get { return route; }
            set { route = value; }
        }

        string stop;                // The Stop Number
        public string Stop
        {
            get { return stop; }
            set { stop = value; }
        }

        string direction;           // The Direction - If From The Feed Then From The <direction> Tag
        public string Direction
        {
            get { return direction; }
            set { direction = value; }
        }

        string stopTitle;           // The StopTitle - If From The Feed Then From The <StopTitle> Tag
        public string StopTitle
        {
            get { return stopTitle; }
            set { stopTitle = value; }
        }

        string agency;              // Selected From The Route (nctd, metrolink, amtrak)
        public string Agency
        {
            get { return agency; }
            set { agency = value; }
        }

        string logo;                // The Displayed Logo Image Name
        public string Logo
        {
            get { return logo; }
            set { logo = value; }
        }

        string logoMessage;
        public string LogoMessage
        {
            get { return logoMessage; }
            set { logoMessage = value; }
        }

        string logoStyle;           // The CSS Style Applied to the Logo
        public string LogoStyle
        {
            get { return logoStyle; }
            set { logoStyle = value; }
        }

        string arrival;             // Estimated Or Scheduled Arrival Time (Minutes Since Midnight)
        public string Arrival
        {
            get { return arrival; }
            set { arrival = value; }
        }
        string arrival2;             // Estimated Or Scheduled Arrival Time (Minutes Since Midnight)
        public string Arrival2
        {
            get { return arrival2; }
            set { arrival2 = value; }
        }

        string arrivalMessage;      // Estimated or Scheduled Message for Arrivals
        public string ArrivalMessage
        {
            get { return arrivalMessage; }
            set { arrivalMessage = value; }
        }
        string arrivalMessage2;      // Estimated or Scheduled Message for Arrivals
        public string ArrivalMessage2
        {
            get { return arrivalMessage2; }
            set { arrivalMessage2 = value; }
        }

        string departure;           // Estimated Or Scheduled Departure Time (Minutes Since Midnight)
        public string Departure
        {
            get { return departure; }
            set { departure = value; }
        }
        string departure2;           // Estimated Or Scheduled Departure Time (Minutes Since Midnight)
        public string Departure2
        {
            get { return departure2; }
            set { departure2 = value; }
        }

        string departureMessage;    // Estimated or Scheduled Message for Departures
        public string DepartureMessage
        {
            get { return departureMessage; }
            set { departureMessage = value; }
        }
        string departureMessage2;    // Estimated or Scheduled Message for Departures
        public string DepartureMessage2
        {
            get { return departureMessage2; }
            set { departureMessage2 = value; }
        }

        bool useEstimate;           // Use The Next Bus Feed (Estimate) Or Not
        public bool useNextBusEstimate
        {
            get { return useEstimate; }
            set { useEstimate = value; }
        }
        bool useEstimate2;           // Use The Next Bus Feed (Estimate) Or Not
        public bool useNextBusEstimate2
        {
            get { return useEstimate2; }
            set { useEstimate2 = value; }
        }

        bool hasEstimate;           // The Next Bus Feed Has an Estimate
        public bool HasNextBusEstimate
        {
            get { return hasEstimate; }
            set { hasEstimate = value; }
        }

        string platform;             // Scheduled Platform
        public string Platform
        {
            get { return platform; }
            set { platform = value; }
        }
        string platform2;             // Scheduled Platform
        public string Platform2
        {
            get { return platform2; }
            set { platform2 = value; }
        }

        string debugMessage;        // Just What It Says
        public string DebugMessage
        {
            get { return debugMessage; }
            set { debugMessage = value; }
        }

        bool IsDelayed;             // Does The Estimate Say That There Is A Delay
        public bool isDelayed
        {
            get { return IsDelayed; }
            set { IsDelayed = value; }
        }
        bool IsDelayed2;             // Does The Estimate Say That There Is A Delay
        public bool isDelayed2
        {
            get { return IsDelayed2; }
            set { IsDelayed2 = value; }
        }
        string BlockID;             // Match The Schedule BlockID to the nexbus block
        public string blockid
        {
            get { return BlockID; }
            set { BlockID = value; }
        }
        string BlockID2;
        public string blockid2
        {
            get { return BlockID2; }
            set { BlockID2 = value; }
        }
        string ScheduleID;             // Use ScheduleID to Debug / Match The Database
        public string ScheduleId
        {
            get { return ScheduleID; }
            set { ScheduleID = value; }
        }
        string ScheduleID2;
        public string ScheduleId2
        {
            get { return ScheduleID2; }
            set { ScheduleID2 = value; }
        }

        public bool isOverridden { get; set; }
    }
}