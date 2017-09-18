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
    public partial class ServiceNotice : System.Web.UI.Page
    {
        // This Page Is For Adding And Updating Service Notices
        int AutoID = 0; // Default Is Add A New Notice - Any Error Produces A New Notice
        DateTime dtDisplayFrom = DateTime.Now;
        DateTime dtDisplayTo = DateTime.Now;
        string strServiceNoticeID = "";
        string strDisplayText = "";
        string style = System.Configuration.ConfigurationManager.AppSettings["ServiceNoticeStyle"];

        // public event EventHandler PreInit
        protected void PreInitEvent(object sender, EventArgs e)
        {
            // http://stackoverflow.com/questions/3339956/asp-net-button-in-codebehind-that-calls-codebehind-function
            // http://stackoverflow.com/questions/10397856/add-aspbutton-from-codebehind
            butSave.Click += new EventHandler(RecordUpSert_Click);
            butCancel.Click += new EventHandler(CancelButton_Click);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            try { AutoID = int.Parse(Request.QueryString["Auto"]); }
            catch { /* Already Handled */ }
            if (!IsPostBack)
            {
                if (AutoID != 0)
                {
                    // Load The Data Here - SELECT 
                    string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["NextBusDisplayConnectionString"].ConnectionString;
                    //try
                    //{
                        string strSQL = string.Format("SELECT TOP 1 ServiceNoticeID, DisplayFrom, DisplayTo, DisplayText " +
                                                      "FROM ServiceNotice WHERE AutoID = {0};", AutoID);
                        using (SqlConnection connection = new SqlConnection(connectionString))
                        {
                            SqlCommand command = new SqlCommand(strSQL, connection);
                            connection.Open();

                            SqlDataReader reader = command.ExecuteReader();

                            if (reader.HasRows)
                            {
                                reader.Read();
                                strServiceNoticeID = reader["ServiceNoticeID"].ToString();
                                dtDisplayFrom = DateTime.Parse(reader["DisplayFrom"].ToString());
                                dtDisplayTo = DateTime.Parse(reader["DisplayTo"].ToString());
                                strDisplayText = reader["DisplayText"].ToString();
                            }

                            // Call Close when done reading.
                            reader.Close();
                        }
                        //DataClasses1DataContext dc = new DataClasses1DataContext();
                        //// dc.ServiceNotices  - DBML Table Name String
                        //var results = (from r in dc.ServiceNotices
                        //           where r.AutoID == int.Parse(AutoID.ToString())
                        //           select r).First(); 
                        //// Force First Even Though There Is Ever Only One In This Definition
                        //dtDisplayFrom = results.DisplayFrom; 
                        //dtDisplayTo = results.DisplayTo;
                        //strServiceNoticeID = results.ServiceNoticeID.Trim().ToString();
                        //strDisplayText = results.DisplayText.Trim().ToString();
                    //}
                    //catch
                    //{
                    //    // Emulate New Record
                    //    AutoID = 0;
                    //    dtDisplayFrom = DateTime.Now;
                    //    dtDisplayTo = DateTime.Now;
                    //    strDisplayText = "";
                    //}

                }
            }
            else
            {
                // Get The Form Data
                //foreach (string key in Request.Form.AllKeys)
                //{
                //    if (key.IndexOf("DisplayFrom") > 0 || key == "DisplayFrom") dtDisplayFrom = DateTime.Parse(Request.Form[key].ToString());
                //    if (key.IndexOf("DisplayTo") > 0 || key == "DisplayTo") dtDisplayTo = DateTime.Parse(Request.Form[key].ToString());
                //    if (key.IndexOf("DisplayText") > 0 || key == "DisplayText") strDisplayText = Request.Form[key].ToString();
                //}

                // PostBack - Get The Values From The Form
                //dtDisplayFrom = DateTime.Parse(Request.Form["DisplayFrom"]);
                //dtDisplayTo = DateTime.Parse(Request.Form["DisplayTo"]);

                //dtDisplayFrom = DateTime.Parse(Request.Form["DisplayFrom"]);
                //strDisplayText = Request.Form["DisplayText"];
                strDisplayText = DisplayText.Text;
                strServiceNoticeID = ServiceNoticeID.Text;
                dtDisplayFrom = DisplayFrom.SelectedDate;
                dtDisplayTo = DisplayTo.SelectedDate;
            }
            // this.form1.ID["DisplayText"] = strDisplayText
            // form1.Controls["DisplayFrom"]
            DisplayText.Text = strDisplayText.Replace("<br />", "\r\n");
            ServiceNoticeID.Text = strServiceNoticeID.Replace("<br />", "");
            DisplayFrom.SelectedDate = dtDisplayFrom;
            DisplayFrom.VisibleDate = dtDisplayFrom;
            DisplayTo.SelectedDate = dtDisplayTo;
            DisplayTo.VisibleDate = dtDisplayTo;

            // Add The Display To the Bottom Table
            Label txtDisplay = new Label();
            txtDisplay.Text = strDisplayText;
            this.ServiceNoticeHolder1.Controls.Add(txtDisplay);
        }
        protected void RecordUpSert_Click(object sender, EventArgs e)
        {
            string strSQL = "";
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["NextBusDisplayConnectionString"].ConnectionString;

            if (AutoID == 0)
            {
                // Insert New Record - AutoID Is Automatically Generated
                strSQL = String.Format("INSERT INTO ServiceNotice (DisplayFrom, DisplayTo, ServiceNoticeID, DisplayText) VALUES ('{0}', '{1}', '{2}', '{3}');", 
                        dtDisplayFrom.ToShortDateString(), dtDisplayTo.ToShortDateString(), 
                        strServiceNoticeID.ToString().Replace("\"", "&#34;").Replace("'","&#39;").Replace("\r\n", ""),
                        strDisplayText.ToString().Replace("\"", "&#34;").Replace("'","&#39;").Replace("\r\n", "<br />"));
            }
            else
            {
                // Update Record - Convert CrLf, \, & ' To Safe Characters
                strSQL = String.Format("UPDATE ServiceNotice SET DisplayFrom='{0}', DisplayTo='{1}', ServiceNoticeID='{2}', DisplayText='{3}' WHERE AutoID = {4};",
                        dtDisplayFrom.ToShortDateString(), dtDisplayTo.ToShortDateString(), 
                        strServiceNoticeID.ToString().Replace("\"", "&#34;").Replace("'","&#39;").Replace("\r\n", ""),
                        strDisplayText.ToString().Replace("\"", "&#34;").Replace("'","&#39;").Replace("\r\n", "<br />"), 
                        AutoID.ToString());
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(strSQL, connection);
                connection.Open();
                command.ExecuteNonQuery();
            }
            // All Done - Go Back To The Main Page
            Response.Redirect("Admin.aspx");
        }
        protected void CancelButton_Click(object sender, EventArgs e)
        {
            // http://msdn.microsoft.com/en-us/library/vstudio/bb342366(v=vs.100).aspx Button.IPostBackEventHandler.RaisePostBackEvent Method 
            //if (IsPostBack)
            //{
                Response.Redirect("Admin.aspx");
            //}
        }

    }
}