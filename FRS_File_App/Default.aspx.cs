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
using DevExpress.Utils;
using DevExpress.Web;

namespace FRS_File_App {
    public partial class _Default : System.Web.UI.Page
    {
        //private FRS_Pen_ReductionEntities db = new FRS_Pen_ReductionEntities();
        string filepath = System.Web.Configuration.WebConfigurationManager.AppSettings["exportFilePath"].ToString();
        string tablename = System.Web.Configuration.WebConfigurationManager.AppSettings["tablename"].ToString();

        string sp_query = System.Web.Configuration.WebConfigurationManager.AppSettings["sp_query"].ToString();

        string payment_filepath = System.Web.Configuration.WebConfigurationManager.AppSettings["export_payment"].ToString();
        protected void Page_Load(object sender, EventArgs e) {
            if (!IsPostBack)
            {
                LoadList();
                DataLoad();

            }
        }

        protected void LoadList()
        {
            cmb_type.Items.Clear();
            cmb_type.Items.Add(new ListEditItem("All"));
            cmb_type.Items.Add(new ListEditItem("Medical"));
            cmb_type.Items.Add(new ListEditItem("Life"));
            cmb_type.SelectedIndex = 0;

            cmb_orderBy.Items.Clear();
            cmb_orderBy.Items.Add(new ListEditItem("LAST"));
            cmb_orderBy.Items.Add(new ListEditItem("MEMBER_ID"));
            cmb_orderBy.Items.Add(new ListEditItem("BILLING_START_DATE"));
            cmb_orderBy.Items.Add(new ListEditItem("CURRENT_DUE"));
            cmb_orderBy.SelectedIndex = 0;


            string first_dayMonth = DateTime.Now.Month.ToString() + "/01/" + DateTime.Now.Year.ToString();
            dateEdit.Date = Convert.ToDateTime(first_dayMonth);

        }

        protected void DataLoad()
        {
            DataView dv = GRIDTABLE().DefaultView;
            dv.Sort = cmb_orderBy.SelectedItem.Text;
            DataTable dt = dv.ToTable();
            ASPxGridView1.DataSource = dt;
            ASPxGridView1.DataBind();
        }


        protected void ASPxGridView1_OnPageIndexChanged(object sender, EventArgs e)
        {
            var view = sender as ASPxGridView;
            if (view == null) return;
            var pageIndex = view.PageIndex;
            ASPxGridView1.PageIndex = pageIndex;
            DataLoad();
        }

        protected void cmb_type_OnSelectedIndexChanged(object sender, EventArgs e)
        {
           DataLoad();
        }

        protected void btn_export_csv_OnClick(object sender, EventArgs e)
        {
           
           ToCSV(GRIDTABLE(), filepath + "\\Raw\\Export.csv");
           string url = "ViewFile.aspx?export=Raw";
           Page.ClientScript.RegisterStartupScript(this.GetType(), "popup_window", "popupwindow('" + url + "','" + "View Download Files" + "','" + "1200" + "','" + "800" + "');", true);

        }

        protected void btn_life_OnClick(object sender, EventArgs e)
        {
            WringML(GRIDTABLE_BYID(1), filepath + "\\life\\Life.csv", 1);
            string url = "ViewFile.aspx?export=Life";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "popup_window", "popupwindow('" + url + "','" + "View Download Files" + "','" + "1200" + "','" + "800" + "');", true);
        }

        protected void btn_medical_OnClick(object sender, EventArgs e)
        {
            WringML(GRIDTABLE_BYID(0), filepath + "\\medical\\Medical.csv", 0);
            string url = "ViewFile.aspx?export=Medical";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "popup_window", "popupwindow('" + url + "','" + "View Download Files" + "','" + "1200" + "','" + "800" + "');", true);
        }

        protected void dateEdit_OnDateChanged(object sender, EventArgs e)
        {
            DataLoad();
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
        
        protected void WringML(DataTable dtDataTable, string strFilePath, int type)
        {
            StreamWriter sw = new StreamWriter(strFilePath, false);


            foreach (DataRow row in dtDataTable.Rows)
            {
                string content = "";
                char padding = Convert.ToChar("0");
                if (type == 0) // medical
                {
                   
                   
                    string ssn = row["SSN"].ToString().Replace("-","").PadRight(9, padding);
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

        protected DataTable GRIDTABLE()
        {
            DataTable table = new DataTable();


            string first_dayMonth = DateTime.Now.Month.ToString() + "-01-" + DateTime.Now.Year.ToString();
            if (dateEdit.Date != null)
            {
                first_dayMonth = dateEdit.Date.ToString("MM-dd-yyyy");
            }
          //  string query = "SELECT * FROM "+ tablename+" WHERE BILLING_START_DATE = '" + first_dayMonth + "' AND PREMIUM_DATE = '" + first_dayMonth + "' ORDER BY "+ cmb_orderBy.SelectedItem.Text;
          string query = "EXEC "+ sp_query+" @Duedate = '" + Convert.ToDateTime(dateEdit.Date) + "' ";
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


                            if (cmb_type.SelectedIndex == 0)
                            {
                                table = dt;
                                //ASPxGridView1.DataSource = dt;
                                //ASPxGridView1.DataBind();
                            }
                            else if (cmb_type.SelectedIndex == 1)
                            {
                                DataTable tblFiltered = dt.AsEnumerable()
                                    .Where(r => r.Field<string>("PLAN_CATEGORY") == "MEDICAL")
                                    .CopyToDataTable();

                                table = tblFiltered;
                                //ASPxGridView1.DataSource = tblFiltered;
                                //ASPxGridView1.DataBind();
                            }
                            else if (cmb_type.SelectedIndex == 2)
                            {
                                DataTable tblFiltered = dt.AsEnumerable()
                                    .Where(r => r.Field<string>("PLAN_CATEGORY") == "LIFE")
                                    .CopyToDataTable();

                                table = tblFiltered;
                                //ASPxGridView1.DataSource = tblFiltered;
                                //ASPxGridView1.DataBind();
                            }



                        }
                    }
                }
            }

            return table;
        } 
        protected DataTable GRIDTABLE_All()
        {
            DataTable table = new DataTable();


            string first_dayMonth = DateTime.Now.Month.ToString() + "-01-" + DateTime.Now.Year.ToString();
            if (dateEdit.Date != null)
            {
                first_dayMonth = dateEdit.Date.ToString("MM-dd-yyyy");
            }
            //string query = "SELECT * FROM " + tablename + " WHERE BILLING_START_DATE = '" + first_dayMonth + "' AND PREMIUM_DATE = '" + first_dayMonth + "' ORDER BY MEMBER_ID";
            string query = "EXEC  " + sp_query + "  @Duedate = '" + Convert.ToDateTime(dateEdit.Date) + "' ";
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
        protected DataTable GRIDTABLE_BYID(int type)
        {
            DataTable table = new DataTable();


            string first_dayMonth = DateTime.Now.Month.ToString() + "-01-" + DateTime.Now.Year.ToString();
            if (dateEdit.Date != null)
            {
                first_dayMonth = dateEdit.Date.ToString("MM-dd-yyyy");
            }
            //string query = "SELECT * FROM " + tablename + " WHERE BILLING_START_DATE = '" + first_dayMonth + "' AND PREMIUM_DATE = '" + first_dayMonth + "' ORDER BY MEMBER_ID";
            string query = "EXEC  " + sp_query + "  @Duedate = '" + Convert.ToDateTime(dateEdit.Date) + "' ";
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

        protected void btn_process_paymentfile_OnClick(object sender, EventArgs e)
        {
            //payment_filepath
            ToCSV(GRIDTABLE_All(), payment_filepath + "\\Import\\PaymentRaw\\PaymentRaw.csv" );

        }

        protected void cmb_orderBy_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            DataLoad();
        }


       

    }
}