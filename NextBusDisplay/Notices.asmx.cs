using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace NextBusDisplay
{
    /// <summary>
    /// Summary description for Notices
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class Notices : System.Web.Services.WebService
    {

        [WebMethod]
        public string GetServiceNotices()
        {
            string noticeTableRows = "";
            // TODO I hate the SQL data reader, so it needs to be redone in SQL, but my attempts below result in
            // The specified type '' is not a valid provider type
            //DataClasses1DataContext dc = new DataClasses1DataContext();
            //DateTime now = DateTime.Now;
            //var dctemp = dc.ServiceNotices.ToList();
            //var notices = dctemp
            //    .Where(sn => sn.DisplayFrom <= now && sn.DisplayTo >= now)
            //    .OrderBy(sn => sn.ServiceNoticeID)
            //    .ThenBy(sn => sn.DisplayFrom)
            //    .ThenBy(sn => sn.DisplayTo)
            //    .Select(sn => sn.DisplayText.ToString());

            //DataClasses1DataContext serviceTable = new DataClasses1DataContext();
            //var notices = (from notice in serviceTable.ServiceNotices
            //               where (notice.DisplayFrom <= DateTime.Now) && (notice.DisplayTo >= DateTime.Now)
            //               orderby notice.DisplayFrom, notice.DisplayTo
            //               select notice.DisplayText.ToString()).ToArray();


            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["NextBusDisplayConnectionString"].ConnectionString;
            string strSQL = "SELECT DisplayText FROM dbo.ServiceNotice " +
                             "WHERE (DisplayFrom <= GETDATE() AND DisplayTo >= CONVERT(date, GETDATE())) " +
                             "ORDER BY DisplayFrom, DisplayTo;";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(strSQL, connection);
                connection.Open();

                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    var dataTable = new DataTable();
                    dataTable.Load(reader);
                    var notices = dataTable.AsEnumerable().ToList();

                    foreach (DataRow row in notices)
                    {
                        string notice = row["DisplayText"].ToString();
                        notice.Replace("\r\n", "<br />");
                        noticeTableRows += $"<tr><td class='ServiceNoticeStyle'>{notice}</td></tr>";
                    }
                }
                else noticeTableRows = "<tr><td class='ServiceNoticeStyle'>No Notices</td></tr>";

                reader.Close();
            }

            return noticeTableRows;
        }
    }
}
