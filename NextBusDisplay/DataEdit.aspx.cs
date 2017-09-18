using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TransitSchedule
{
    public partial class DataEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string strSQL = "";
            DataClasses1DataContext dc = new DataClasses1DataContext();
            //if (Request.QueryString.Get("Submit") != String.Empty) PopulateTable();
            // Load The SQL
            //switch ()
            //    case 1:
            //        {
            ////<input type="submit" id="Stops" value="Stops" />&nbsp; <!-- [NextBusDisplay].[dbo].[StopDisplay] -->
            //        break;
            //        }
            //<input type="submit" id="StaticTrainA" value="Amtrak Static Trains" />&nbsp; <!-- [NextBusDisplay].[dbo].[StaticTrains] -->
            //<input type="submit" id="StaticTrainC" value="Coaster Static Trains" />&nbsp; <!-- [NextBusDisplay].[dbo].[StaticTrains] -->
            //<input type="submit" id="StaticTrainM" value="Metrolink Static Trains" />&nbsp; <!-- [NextBusDisplay].[dbo].[StaticTrains] -->
            //<input type="submit" id="StaticTrainS" value="Sprinter Static Trains" />&nbsp; <!-- [NextBusDisplay].[dbo].[StaticTrains] -->
            //<input type="submit" id="platformov" value="Platform Override" />&nbsp; <!-- [NextBusDisplay].[dbo].[PlatformOverride] -->
            //<input type="submit" id="Holidays" value="Holidays" /> <!-- [NextBusDisplay].[dbo].[tblHoliDate] -->

            if (strSQL != "") // No SQL - No Display
            {
                // Execute The SQL


                // Apply the SQL To The GridView
            }
        }
    }
}