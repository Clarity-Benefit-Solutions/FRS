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
    public partial class TableEdit : System.Web.UI.Page
    {
        string tablename = System.Web.Configuration.WebConfigurationManager.AppSettings["edit_table"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadList();
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



            cmb_last.Items.Clear();
            cmb_last.Items.Add(new ListEditItem("All"));
            DataTable dt_last = GRIDTABLE("[LAST]");

            foreach (DataRow row in dt_last.Rows)
            {
                string last = row["LAST"].ToString();
                cmb_last.Items.Add(new ListEditItem(last));
            }

            cmb_last.SelectedIndex = 0;


        }


        protected DataTable GRIDTABLE(string item)
        {
            DataTable table = new DataTable();

            string query = "SELECT " + item + " FROM " + tablename+ "GROUP BY "+ item;

            
          
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

            if (!string.IsNullOrEmpty(cmb_first.Text))
            {
                if (cmb_first.SelectedIndex != 0)
                {
                    string text = cmb_first.Text;

                    query += "AND FIRST='" + text + "' ";
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
            WringML(GRIDTABLE_export(1), filepath + "\\life\\Life.csv", 1);
            string url = "ViewFile.aspx?export=Life";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "popup_window", "popupwindow('" + url + "','" + "View Download Files" + "','" + "1200" + "','" + "800" + "');", true);
        }

        protected void btn_medical_OnClick(object sender, EventArgs e)
        {
            WringML(GRIDTABLE_export(0), filepath + "\\medical\\Medical.csv", 0);
            string url = "ViewFile.aspx?export=Medical";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "popup_window", "popupwindow('" + url + "','" + "View Download Files" + "','" + "1200" + "','" + "800" + "');", true);
        }

        protected void WringML(DataTable dtDataTable, string strFilePath, int type)
        {
            StreamWriter sw = new StreamWriter(strFilePath, false);


            foreach (DataRow row in dtDataTable.Rows)
            {
                string content = "";
                char padding = Convert.ToChar("0");
                if (type == 0) // medical
                {


                    string ssn = row["SSN"].ToString().Replace("-", "").PadRight(9, padding);
                    string medical = string.Format("{0:C}", row["CURRENT_DUE"].ToString()).Replace("$", "").Replace(" ", "").Replace(".", "").PadLeft(11, padding);
                    content = "RP140 440 " + ssn + " " + medical;
                }
                else // life
                {

                    string ssn = row["SSN"].ToString().Replace("-", "").PadRight(9, padding);
                    string life = string.Format("{0:C}", row["CURRENT_DUE"].ToString()).Replace("$", "").Replace(" ", "").Replace(".", "").PadLeft(11, padding);
                    content = "RP141 441 " + ssn + " " + life;
                }

                sw.Write(content);
                sw.Write(sw.NewLine);
            }

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

                TextBox lbl_Amount_Due2 =
                    ASPxGridView1.FindRowCellTemplateControl(i, null, "lbl_Amount_Due2") as TextBox;


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

            //using (SqlConnection con = new SqlConnection(constr))
            //{
            //    using (SqlCommand cmd = new SqlCommand(query))
            //    {
            //        using (SqlDataAdapter sda = new SqlDataAdapter())
            //        {
            //            cmd.Connection = con;
            //            sda.UpdateCommand = cmd;

            //        }
            //    }
            //}
        }

        protected void btn_save_OnClick(object sender, EventArgs e)
        {
            save_all();
            DataLoad();
        }
    }
}