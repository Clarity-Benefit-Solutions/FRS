using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Export;
using DevExpress.Web;
using DevExpress.XtraPrinting;

namespace FRS_File_App
{
    public partial class TableEdit_AUG2022 : System.Web.UI.Page
    {
        #region parameter
        string tablename = System.Web.Configuration.WebConfigurationManager.AppSettings["table_aug"].ToString();
        //string viewname = System.Web.Configuration.WebConfigurationManager.AppSettings["view_query_MAY"].ToString();

        int thisMonth = 08;
        int thisyear = 2022;
        string returnurl = "TableEdit_SEP2022.aspx";
        string updatequery = "UPDATE [dbo].[ReportSettings] SET Flag = 1 WHERE [MONTH] = 'AUG' AND [YEAR] = 2022";

        string filepath = System.Web.Configuration.WebConfigurationManager.AppSettings["exportFilePath"].ToString();


        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                dateEdit.Date = Convert.ToDateTime(thisMonth.ToString() + "/01/" + thisyear.ToString());
                //DataLoad_Missing();

            }
        }

        #region Archive Button
        protected void btn_archive_OnClick(object sender, EventArgs e)
        {
            update_status();

            Response.Redirect(returnurl);

        }

        protected void update_status()
        {
            string Sql = updatequery;
            string ConnectionString = ConfigurationManager.ConnectionStrings["FRS_Pen_ReductionConnectionString"].ConnectionString;

            using (SqlConnection oSqlConnection = new SqlConnection(ConnectionString))
            {
                SqlCommand oSqlCommand = new SqlCommand(Sql, oSqlConnection);
                try
                {
                    oSqlConnection.Open();
                    oSqlCommand.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message.ToString());
                }
                finally
                {
                    oSqlCommand.Dispose();
                    oSqlConnection.Close();
                    oSqlConnection.Dispose();

                }
            }


        }

        #endregion

        #region RawData Button

        protected void btn_export_csv_OnClick(object sender, EventArgs e)
        {
            gridExport.WriteCsvToResponse(new CsvExportOptionsEx { ExportType = ExportType.WYSIWYG });
            //string url = "ViewFile.aspx?export=Raw";
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "popup_window", "popupwindow('" + url + "','" + "View Download Files" + "','" + "1200" + "','" + "800" + "');", true);

        }


        protected void ToCSV(DataTable dtDataTable, string strFilePath)
        {
            StreamWriter sw = new StreamWriter(strFilePath, false);
            //headers    
            for (int i = 0; i < dtDataTable.Columns.Count; i++)
            {
                sw.Write(dtDataTable.Columns[i]);
                if (i < dtDataTable.Columns.Count - 1)
                {
                    sw.Write(",");
                }
            }
            sw.Write(sw.NewLine);
            foreach (DataRow dr in dtDataTable.Rows)
            {
                for (int i = 0; i < dtDataTable.Columns.Count; i++)
                {
                    if (!Convert.IsDBNull(dr[i]))
                    {
                        string value = dr[i].ToString();
                        if (value.Contains(','))
                        {
                            value = String.Format("\"{0}\"", value);
                            sw.Write(value);
                        }
                        else
                        {
                            sw.Write(dr[i].ToString());
                        }
                    }
                    if (i < dtDataTable.Columns.Count - 1)
                    {
                        sw.Write(",");
                    }
                }
                sw.Write(sw.NewLine);
            }
            sw.Close();
        }

        #endregion 

        #region  Life and Medical
        protected void btn_life_OnClick(object sender, EventArgs e)
        {
            WringML(GRIDTABLE_export(1), filepath + "\\life\\RP140_441_IRC_FOR_EXPORT.txt", 1);
            string url = "ViewFile.aspx?export=Life";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "popup_window", "popupwindow('" + url + "','" + "View Download Files" + "','" + "1200" + "','" + "800" + "');", true);
        }

        protected void btn_medical_OnClick(object sender, EventArgs e)
        {
            WringML(GRIDTABLE_export(0), filepath + "\\medical\\RP140_440_IRC_FOR_EXPORT.txt", 0);
            string url = "ViewFile.aspx?export=Medical";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "popup_window", "popupwindow('" + url + "','" + "View Download Files" + "','" + "1200" + "','" + "800" + "');", true);
        }

        protected void WringML(DataTable dtDataTable, string strFilePath, int type)
        {
            StreamWriter sw = new StreamWriter(strFilePath, false);

            int count = 0;
            double total = 0;

            foreach (DataRow row in dtDataTable.Rows)
            {
                string content = "";
                char padding = Convert.ToChar("0");
                if (type == 0) // medical
                {


                    string ssn = row["SSN"].ToString().Replace("-", "").PadRight(9, padding);
                    string medical = string.Format("{0:C}", row["CURRENT_DUE"].ToString()).Replace("$", "").Replace(" ", "").Replace(".", "").PadLeft(11, padding);
                    content = "RP140 440 " + ssn + " " + medical;

                    double local_total = 0;
                    double.TryParse(row["CURRENT_DUE"].ToString().Replace("$", "").Replace(" ", "").Replace(".", ""), out local_total);
                    total += local_total;
                }
                else // life
                {

                    string ssn = row["SSN"].ToString().Replace("-", "").PadRight(9, padding);
                    string life = string.Format("{0:C}", row["CURRENT_DUE"].ToString()).Replace("$", "").Replace(" ", "").Replace(".", "").PadLeft(11, padding);
                    content = "RP140 441 " + ssn + " " + life;


                    double local_total = 0;
                    double.TryParse(row["CURRENT_DUE"].ToString().Replace("$", "").Replace(" ", "").Replace(".", ""), out local_total);
                    total += local_total;
                }

                sw.Write(content);
                sw.Write(sw.NewLine);

                count++;
            }

            sw.Write("*****" + count.ToString().PadLeft(6, '0') + total.ToString().PadLeft(11, '0'));
            sw.Close();
        }
        protected DataTable GRIDTABLE_export(int type)
        {
            DataTable table = new DataTable();
            string query = "SELECT * FROM " + tablename + " WHERE MEMBER_ID IS NOT NULL ";


            string constr = ConfigurationManager.ConnectionStrings["FRS_Pen_ReductionConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);


                            if (type == 0)
                            {
                                DataTable tblFiltered = dt.AsEnumerable()
                                    .Where(r => r.Field<string>("PLAN_CATEGORY") == "MEDICAL")
                                    .CopyToDataTable();

                                table = tblFiltered;
                                //ASPxGridView1.DataSource = tblFiltered;
                                //ASPxGridView1.DataBind();
                            }
                            else if (type == 1)
                            {
                                DataTable tblFiltered = dt.AsEnumerable()
                                    .Where(r => r.Field<string>("PLAN_CATEGORY") == "LIFE")
                                    .CopyToDataTable();

                                table = tblFiltered;
                                //ASPxGridView1.DataSource = tblFiltered;
                                //ASPxGridView1.DataBind();
                            }

                            else if (type == 3)
                            {
                                table = dt;
                                //ASPxGridView1.DataSource = tblFiltered;
                                //ASPxGridView1.DataBind();
                            }
                        }
                    }
                }
            }

            return table;
        }
        #endregion

        protected void ASPxGridView2_PageIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ASPxGridView2_RowCommand(object sender, ASPxGridViewRowCommandEventArgs e)
        {
            //if (e.CommandArgs.CommandName == "add")
            //{
            //    string Sql = " EXEC [dbo].[Add_NULL_ZERO] @SSN='" + e.CommandArgs.CommandArgument.ToString() + "'";


            //    string ConnectionString = ConfigurationManager.ConnectionStrings["FRS_Pen_ReductionConnectionString"].ConnectionString;

            //    using (SqlConnection oSqlConnection = new SqlConnection(ConnectionString))
            //    {
            //        SqlCommand oSqlCommand = new SqlCommand(Sql, oSqlConnection);
            //        try
            //        {
            //            oSqlConnection.Open();
            //            oSqlCommand.ExecuteNonQuery();
            //        }
            //        catch (Exception ex)
            //        {
            //            throw new Exception(ex.Message.ToString());
            //        }
            //        finally
            //        {
            //            oSqlCommand.Dispose();
            //            oSqlConnection.Close();
            //            oSqlConnection.Dispose();

            //        }
            //    }


            //    DataLoad_Missing();

            //}
        }

        //protected void DataLoad_Missing()
        //{

        //    DataTable dt = GRIDTABLE_MISSING();
        //    ASPxGridView2.DataSource = dt;
        //    ASPxGridView2.DataBind();
        //}

        protected DataTable GRIDTABLE_MISSING()
        {
            DataTable table = new DataTable();
            string query = "SELECT  * FROM [dbo].[FRS_OUTPUT_END_MEMBERS] WHERE FLAG = 0";
            string constr = ConfigurationManager.ConnectionStrings["FRS_Pen_ReductionConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);


                            table = dt;
                        }
                    }
                }
            }

            return table;
        }
    }
}