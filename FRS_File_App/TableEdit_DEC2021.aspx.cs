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
using DevExpress.Web;

namespace FRS_File_App
{
    public partial class TableEdit_DEC2021 : System.Web.UI.Page
    {
        #region parameter
        string tablename = System.Web.Configuration.WebConfigurationManager.AppSettings["table_dec"].ToString();
        string viewname = System.Web.Configuration.WebConfigurationManager.AppSettings["view_query_DEC"].ToString();
        int lastMonth = 12;
        int thisMonth = 01;
        int thisyear = 2022;
        string returnurl = "TableEdit_JAN2022.aspx";
        string updatequery = "UPDATE [dbo].[ReportSettings] SET Flag = 1 WHERE [MONTH] = 'JAN' AND [YEAR] = 2022";
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadList();
                DataLoad_Missing();
                dateEdit.Date = Convert.ToDateTime(thisMonth.ToString() + "/01/" + thisyear.ToString());
                DataLoad();

            }
        }

        protected void LoadList()
        {
            cmb_first.Items.Clear();
            cmb_first.Items.Add(new ListEditItem("All"));
            DataTable dt_first = GRIDTABLE("[FIRST]");

            foreach (DataRow row in dt_first.Rows)
            {
                string first = row["FIRST"].ToString();
                cmb_first.Items.Add(new ListEditItem(first));
            }

            cmb_first.SelectedIndex = 0;


            //ENROLLED_PLANS

            cmb_ENROLLED_PLANS.Items.Clear();
            cmb_ENROLLED_PLANS.Items.Add(new ListEditItem("All"));
            DataTable dt_ENROLLED_PLANS = GRIDTABLE("[ENROLLED_PLANS]");

            foreach (DataRow row in dt_ENROLLED_PLANS.Rows)
            {
                string first = row["ENROLLED_PLANS"].ToString();
                cmb_ENROLLED_PLANS.Items.Add(new ListEditItem(first));
            }

            cmb_ENROLLED_PLANS.SelectedIndex = 0;


            //COVERAGE_LEVEL

            cmb_COVERAGE_LEVEL.Items.Clear();
            cmb_COVERAGE_LEVEL.Items.Add(new ListEditItem("All"));
            DataTable dt_COVERAGE_LEVEL = GRIDTABLE("[COVERAGE_LEVEL]");

            foreach (DataRow row in dt_COVERAGE_LEVEL.Rows)
            {
                string first = row["COVERAGE_LEVEL"].ToString();
                cmb_COVERAGE_LEVEL.Items.Add(new ListEditItem(first));
            }

            cmb_COVERAGE_LEVEL.SelectedIndex = 0;


            //PLAN_CATEGORY
            cmb_PLAN_CATEGORY.Items.Clear();
            cmb_PLAN_CATEGORY.Items.Add(new ListEditItem("All"));
            DataTable dt_PLAN_CATEGORY = GRIDTABLE("[PLAN_CATEGORY]");

            foreach (DataRow row in dt_PLAN_CATEGORY.Rows)
            {
                string first = row["PLAN_CATEGORY"].ToString();
                cmb_PLAN_CATEGORY.Items.Add(new ListEditItem(first));
            }

            cmb_PLAN_CATEGORY.SelectedIndex = 0;



            cmb_ssn.Items.Clear();
            cmb_ssn.Items.Add(new ListEditItem("All"));
            DataTable dt_cmb_ssn = GRIDTABLE("[SSN]");

            foreach (DataRow row in dt_cmb_ssn.Rows)
            {
                string ssn = row["SSN"].ToString();
                cmb_ssn.Items.Add(new ListEditItem(ssn));
            }

            cmb_ssn.SelectedIndex = 0;


            cmb_last.Items.Clear();
            cmb_last.Items.Add(new ListEditItem("All"));
            DataTable dt_last = GRIDTABLE("[LAST]");

            foreach (DataRow row in dt_last.Rows)
            {
                string last = row["LAST"].ToString();
                cmb_last.Items.Add(new ListEditItem(last));
            }

            cmb_last.SelectedIndex = 0;

            //CURRENT_DUE
            cmb_TotalAmount.Items.Clear();
            cmb_TotalAmount.Items.Add(new ListEditItem("All"));
            DataTable dt_cmb_TotalAmount = GRIDTABLE("[CURRENT_DUE]");

            foreach (DataRow row in dt_cmb_TotalAmount.Rows)
            {
                string last = row["CURRENT_DUE"].ToString();
                cmb_TotalAmount.Items.Add(new ListEditItem(last));
            }

            cmb_TotalAmount.SelectedIndex = 0;
        }


        protected DataTable GRIDTABLE(string item)
        {
            DataTable table = new DataTable();

            string query = "SELECT " + item + " FROM " + tablename + "GROUP BY " + item;



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

        protected DataTable GRIDTABLE_All()
        {
            DataTable table = new DataTable();
            string query = "SELECT * FROM " + tablename + " WHERE MEMBER_ID IS NOT NULL ";


            if (cmb_type.SelectedIndex == 1)
            {

                query += "AND PLAN_CATEGORY='LIFE' ";
            }
            else if (cmb_type.SelectedIndex == 2)
            {
                query += "AND PLAN_CATEGORY='MEDICAL' ";
            }

            if (cmb_enddate.SelectedIndex == 1)
            {
                query += " AND END_DATE IS NULL ";
            }
            else if (cmb_enddate.SelectedIndex == 2)
            {
                query += " AND END_DATE IS NOT NULL AND END_DATE <= '" + thisMonth.ToString() + "/01/" + thisyear.ToString() + "' ";
            }
            else if (cmb_enddate.SelectedIndex == 3)
            {
                query += " AND END_DATE IS NOT NULL AND END_DATE > '" + thisMonth.ToString() + "/01/" + thisyear.ToString() + "' ";
            }

            if (cmb_unallocatedAmount.SelectedIndex == 1)
            {
                query += "AND UnallocatedAmount > 0 ";
            }
            else if (cmb_unallocatedAmount.SelectedIndex == 2)
            {
                query += "AND UnallocatedAmount = 0 ";
            }

            if (cmb_status.SelectedIndex == 1)
            {
                query += "AND FLAG = 1";
            }
            else
            if (cmb_status.SelectedIndex == 2)
            {
                query += "AND FLAG = 0";
            }
            else
            if (cmb_status.SelectedIndex == 3)
            {
                query += "AND FLAG = 2";
            }


            if (!string.IsNullOrEmpty(cmb_first.Text))
            {
                if (cmb_first.SelectedIndex != 0)
                {
                    string text = cmb_first.Text;

                    query += "AND FIRST='" + text + "' ";
                }

            }

            if (!string.IsNullOrEmpty(cmb_TotalAmount.Text))
            {
                if (cmb_TotalAmount.SelectedIndex != 0)
                {
                    string text = cmb_TotalAmount.Text;

                    query += "AND CURRENT_DUE='" + text + "' ";
                }

            }


            if (!string.IsNullOrEmpty(cmb_ssn.Text))
            {
                if (cmb_ssn.SelectedIndex != 0)
                {
                    string text = cmb_ssn.Text;

                    query += "AND SSN='" + text + "' ";
                }

            }


            //PLAN_CATEGORY
            //COVERAGE_LEVEL
            //ENROLLED_PLANS
            //ENROLLED_PLANS
            if (!string.IsNullOrEmpty(cmb_PLAN_CATEGORY.Text))
            {
                if (cmb_PLAN_CATEGORY.SelectedIndex != 0)
                {
                    string text = cmb_PLAN_CATEGORY.Text;

                    query += "AND PLAN_CATEGORY='" + text + "' ";
                }

            }
            if (!string.IsNullOrEmpty(cmb_COVERAGE_LEVEL.Text))
            {
                if (cmb_COVERAGE_LEVEL.SelectedIndex != 0)
                {
                    string text = cmb_COVERAGE_LEVEL.Text;

                    query += "AND COVERAGE_LEVEL='" + text + "' ";
                }

            }
            if (!string.IsNullOrEmpty(cmb_ENROLLED_PLANS.Text))
            {
                if (cmb_ENROLLED_PLANS.SelectedIndex != 0)
                {
                    string text = cmb_ENROLLED_PLANS.Text;

                    query += "AND ENROLLED_PLANS='" + text + "' ";
                }

            }



            if (!string.IsNullOrEmpty(cmb_last.Text))
            {
                if (cmb_last.SelectedIndex != 0)
                {
                    string text = cmb_last.Text;

                    query += "AND LAST='" + text + "' ";
                }

            }

            query += " ORDER BY " + cmb_orderby.Text + " " + cmb_ad.Text;

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

        protected DataTable GRIDTABLE_MISSING()
        {
            DataTable table = new DataTable();
            string query = "SELECT  * FROM " + viewname;




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

        protected void DataLoad()
        {

            DataTable dt = GRIDTABLE_All();
            ASPxGridView1.DataSource = dt;
            ASPxGridView1.DataBind();
        }

        protected void DataLoad_Missing()
        {

            DataTable dt = GRIDTABLE_MISSING();
            ASPxGridView2.DataSource = dt;
            ASPxGridView2.DataBind();
        }

        string filepath = System.Web.Configuration.WebConfigurationManager.AppSettings["exportFilePath"].ToString();
        protected void btn_export_csv_OnClick(object sender, EventArgs e)
        {
            ToCSV(GRIDTABLE_export(3), filepath + "\\Raw\\Export.csv");
            string url = "ViewFile.aspx?export=Raw";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "popup_window", "popupwindow('" + url + "','" + "View Download Files" + "','" + "1200" + "','" + "800" + "');", true);

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

        protected void ASPxGridView1_OnPageIndexChanged(object sender, EventArgs e)
        {
            var view = sender as ASPxGridView;
            if (view == null) return;
            var pageIndex = view.PageIndex;
            ASPxGridView1.PageIndex = pageIndex;
            DataLoad();
        }

        protected void cmb_first_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            DataLoad();
        }

        protected void cmb_last_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            DataLoad();
        }

        protected void save_all()
        {
            for (int i = 0; i < ASPxGridView1.VisibleRowCount; i++)
            {
                Label lbl_PLAN_CATEGORY =
                    ASPxGridView1.FindRowCellTemplateControl(i, null, "lbl_PLAN_CATEGORY") as Label;

                Label lbl_MEMBER_ID =
                    ASPxGridView1.FindRowCellTemplateControl(i, null, "lbl_MEMBER_ID") as Label;

                ASPxTextBox lbl_Amount_Due2 =
                    ASPxGridView1.FindRowCellTemplateControl(i, null, "lbl_Amount_Due2") as ASPxTextBox;


                if (lbl_Amount_Due2 != null)
                {
                    string text = lbl_Amount_Due2.Text.Replace("$", "");
                    double amount = 0;
                    double.TryParse(lbl_Amount_Due2.Text, out amount);

                    if (lbl_PLAN_CATEGORY != null && lbl_MEMBER_ID != null)
                    {
                        string cat = lbl_PLAN_CATEGORY.Text;
                        string memid = lbl_MEMBER_ID.Text;

                        //Response.Write(cat);
                        //Response.Write(memid);

                        updateCommand(cat, memid, amount);

                    }

                }





            }
        }

        protected void updateCommand(string val1, string val2, double due_Amount)
        {
            string Sql = "UPDATE " + tablename + " SET CURRENT_DUE=" + due_Amount + " WHERE PLAN_CATEGORY='" + val1 +
                         "' AND MEMBER_ID='" + val2 + "' ";
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

        protected void btn_save_OnClick(object sender, EventArgs e)
        {
            save_all();
            DataLoad();
        }


        protected void btn_add_OnClick(object sender, EventArgs e)
        {

            string Sql = " INSERT INTO  " + tablename + " SELECT * FROM " + viewname;


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


            DataLoad();
        }



        protected void ASPxGridView1_OnRowCommand(object sender, ASPxGridViewRowCommandEventArgs e)
        {

            if (e.CommandArgs.CommandName == "delete")
            {
                string id = e.CommandArgs.CommandArgument.ToString();
                string Sql = "DELETE FROM " + tablename + " WHERE SSN = '" + id + "' AND FLAG=4";


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

                DataLoad();
            }
            else if (e.CommandArgs.CommandName == "edit")
            {
                string memid = e.CommandArgs.CommandArgument.ToString();
                ASPxGridView gridview = (ASPxGridView)sender;
                ASPxTextBox lbl_Amount_Due2 = ASPxGridView1.FindRowCellTemplateControl(e.VisibleIndex, null, "lbl_Amount_Due2") as ASPxTextBox;
                Label lbl_PLAN_CATEGORY = ASPxGridView1.FindRowCellTemplateControl(e.VisibleIndex, null, "lbl_PLAN_CATEGORY") as Label;

                if (lbl_Amount_Due2 != null && lbl_PLAN_CATEGORY != null)
                {
                    string text = lbl_Amount_Due2.Text.Replace("$", "");
                    double amount = 0;
                    double.TryParse(lbl_Amount_Due2.Text, out amount);


                    string cat = lbl_PLAN_CATEGORY.Text;

                    updateCommand(cat, memid, amount);


                    //DataLoad();
                }
            }
        }





        protected void btn_archive_OnClick(object sender, EventArgs e)
        {
            update_status();

            Response.Redirect(returnurl);

        }


        #region update status

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
    }
}