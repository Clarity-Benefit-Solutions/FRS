<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="TableEdit_OCT2022.aspx.cs" Inherits="FRS_File_App.TableEdit_OCT2022" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function popupwindow(url, title, w, h) {
            var left = (screen.width / 2) - (w / 2);
            var top = (screen.height / 2) - (h / 2);
            return window.open(url, title, 'toolbar=no, location=no, directories=no, status=no,      menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
        }
    </script>

    <div class="row">
        <div class="col-sm-12"></div>

        <div style="float: left; width: 100%; margin-top: 30px; margin-bottom: 20px" class="page-header">
            <dx:ASPxDateEdit ID="dateEdit" runat="server" EditFormat="Custom" Enabled="false" Caption="PREMIUM DUE DATE"
                Theme="Moderno" Width="120px">
                <TimeSectionProperties>
                    <TimeEditProperties EditFormatString="MM/dd/yyyy" />
                </TimeSectionProperties>
            </dx:ASPxDateEdit>
        </div>

        <div style="float: right; margin-bottom: 30px">
            <dx:ASPxButton runat="server" ID="btn_archive" Text="Archive"
                OnClick="btn_archive_OnClick" Theme="Moderno">
            </dx:ASPxButton>
            &nbsp;&nbsp;
                                      <%--  <dx:ASPxButton runat="server" ID="btn_save" Text="Save All Changes" OnClick="btn_save_OnClick" Theme="MaterialCompact" ></dx:ASPxButton>
                                        &nbsp;&nbsp;--%>
            <dx:ASPxButton runat="server" ID="btn_export_csv" Text="RAW DATA CSV"
                OnClick="btn_export_csv_OnClick" Theme="iOS">
            </dx:ASPxButton>
            &nbsp;&nbsp;<dx:ASPxButton runat="server" ID="btn_life" Text="LIFE CSV" OnClick="btn_life_OnClick" Theme="Moderno"></dx:ASPxButton>
            &nbsp;&nbsp;<dx:ASPxButton runat="server" ID="btn_medical" Text="MEDICAL CSV" OnClick="btn_medical_OnClick" Theme="Moderno"></dx:ASPxButton>
        </div>


        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" Width="100%"
            DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="ID" Theme="MaterialCompact">
            <SettingsPager PageSize="100">
            </SettingsPager>
            <Settings HorizontalScrollBarMode="Visible" VerticalScrollableHeight="600" VerticalScrollBarMode="Auto" />
            <Settings ShowFilterRow="True" ShowFooter="True" />
            <SettingsDataSecurity AllowDelete="true" AllowInsert="False" />
            <Columns>
                <dx:GridViewDataTextColumn FieldName="MEMBER_ID" VisibleIndex="1" Width="150">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="FIRST" VisibleIndex="2" FixedStyle="Left" Width="150">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LAST" VisibleIndex="3" FixedStyle="Left" Width="150">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SSN" VisibleIndex="4" Width="150">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="BILLING_START_DATE" VisibleIndex="5" Width="150">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="BILLING_FREQUENCY" VisibleIndex="6" Width="150">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ENROLLED_PLANS" VisibleIndex="7" Width="150">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="COVERAGE_LEVEL" VisibleIndex="8" Width="150">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="STATUS" VisibleIndex="9" Width="150">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="PREMIUM_DATE" VisibleIndex="10" Caption="NEXT PREMIUM DUE" Width="150" FixedStyle="Left">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="BILLING_TYPE" VisibleIndex="11" Width="150">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ACCOUNT_TYPE" VisibleIndex="12" Width="150">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="RATE_TYPE" VisibleIndex="13" Width="150">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataColumn Caption="END DATE" VisibleIndex="13" Width="180px" FieldName="END_DATE">
                    <SettingsHeaderFilter>
                        <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                    </SettingsHeaderFilter>
                    <DataItemTemplate>
                        <dx:ASPxLabel ID="lbl_enddate" runat="server"
                            Text='<%# string.IsNullOrEmpty(Eval("END_DATE").ToString()) ? "N/A":  
                                    Convert.ToDateTime(Eval("END_DATE").ToString()).ToString("MM/dd/yyyy") %>'
                            Theme="Moderno">
                        </dx:ASPxLabel>

                    </DataItemTemplate>
                </dx:GridViewDataColumn>
                <dx:GridViewDataColumn Caption="Unallocated Amount($)" VisibleIndex="14" Width="180px" FieldName="UnallocatedAmount">
                    <SettingsHeaderFilter>
                        <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                    </SettingsHeaderFilter>
                    <DataItemTemplate>
                        <dx:ASPxLabel ID="lbl_UnallocatedAmount" runat="server" Text='<%# string.Format("{0:C}", Eval("UnallocatedAmount")) %>' DisplayFormatString="C" Theme="Moderno"></dx:ASPxLabel>

                    </DataItemTemplate>
                </dx:GridViewDataColumn>
                <dx:GridViewDataColumn Caption="Member Owe($)" VisibleIndex="15" Width="150px" FieldName="MemberOwes">
                    <SettingsHeaderFilter>
                        <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                    </SettingsHeaderFilter>
                    <DataItemTemplate>
                        <dx:ASPxLabel ID="lbl_MemberOwes" runat="server" Text='<%# string.Format("{0:C}", Eval("MemberOwes")) %>'
                            DisplayFormatString="C" Theme="Moderno">
                        </dx:ASPxLabel>

                    </DataItemTemplate>
                </dx:GridViewDataColumn>
                <dx:GridViewDataColumn Caption="Current Premium Due($)" VisibleIndex="16" Width="180px">
                    <SettingsHeaderFilter>
                        <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                    </SettingsHeaderFilter>
                    <DataItemTemplate>
                        <dx:ASPxLabel ID="lbl_Amount_Due" runat="server"
                            Text='<%#Eval("PLAN_CATEGORY").ToString() =="MEDICAL"? string.Format("{0:C}",Eval("MEDICAL")) :string.Format("{0:C}", Eval("LIFE")) %>' DisplayFormatString="C">
                        </dx:ASPxLabel>

                    </DataItemTemplate>
                </dx:GridViewDataColumn>
                <dx:GridViewDataTextColumn FieldName="PLAN_CATEGORY" VisibleIndex="17">
                </dx:GridViewDataTextColumn>
                <%--    <dx:GridViewDataTextColumn FieldName="CURRENT_DUE" VisibleIndex="18">
                    </dx:GridViewDataTextColumn>--%>
                <dx:GridViewDataColumn Caption="Total Amount Due($)" VisibleIndex="16" Width="180px" FieldName="CURRENT_DUE">
                    <SettingsHeaderFilter>
                        <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                    </SettingsHeaderFilter>
                    <DataItemTemplate>

                        <dx:ASPxLabel ID="lbl_MemberOwes" runat="server" Text='<%# string.Format("{0:C}", Eval("CURRENT_DUE")) %>' DisplayFormatString="C" Theme="Moderno"></dx:ASPxLabel>

                    </DataItemTemplate>
                </dx:GridViewDataColumn>
                <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="24" Visible="False">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewCommandColumn ShowEditButton="True" VisibleIndex="25" ShowDeleteButton="True">
                </dx:GridViewCommandColumn>

            </Columns>

            <SettingsPopup>
                <FilterControl AutoUpdatePosition="False"></FilterControl>
            </SettingsPopup>

            <EditFormLayoutProperties ColCount="5">
                <Items>
                    <dx:GridViewColumnLayoutItem ColumnName="MEMBER_ID" Caption="MEMBER ID" />

                    <%--<dx:GridViewColumnLayoutItem ColumnName="UnallocatedAmount" />--%>
                    <dx:GridViewColumnLayoutItem ColumnName="PLAN_CATEGORY" />
                    <dx:GridViewColumnLayoutItem ColumnName="FIRST" />
                    <dx:GridViewColumnLayoutItem ColumnName="LAST" />
                    <dx:GridViewColumnLayoutItem ColumnName="CURRENT_DUE" />
                    <dx:EditModeCommandLayoutItem Width="100%" HorizontalAlign="Right" />
                </Items>

                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="600"></SettingsAdaptivity>
            </EditFormLayoutProperties>
            <EditFormLayoutProperties>
                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="600" />
            </EditFormLayoutProperties>

        </dx:ASPxGridView>


        <dx:ASPxGridViewExporter ID="gridExport" runat="server" GridViewID="ASPxGridView1"></dx:ASPxGridViewExporter>
    </div>

    <div style="width: 100%; text-align: center; font-weight: bold; margin-top: 30px" class="text-primary">
        <h4>Ended in the past or Null Next Due Date</h4>
    </div>

    <%--    <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False"  
                OnPageIndexChanged="ASPxGridView2_PageIndexChanged" Theme="MaterialCompact" OnRowCommand="ASPxGridView2_RowCommand"
                Width="100%">
              
                <Settings HorizontalScrollBarMode="Visible" VerticalScrollableHeight="400" VerticalScrollBarMode="Auto" />
                <SettingsPager PageSize="100" />
                <Paddings Padding="0px" />
                <Border BorderWidth="0px" />
                <BorderBottom BorderWidth="1px" />
        
                <Columns>
                     
                     <dx:GridViewDataColumn Caption="MEMBER_ID" VisibleIndex="0" Width="150px">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                            <asp:Label ID="lbl_MEMBER_ID" runat="server" Text='<%#   Eval("MEMBER_ID") %>'  ></asp:Label>

                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataTextColumn FieldName="FIRST" VisibleIndex="1" FixedStyle="Left">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="LAST" VisibleIndex="2" FixedStyle="Left">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="SSN" VisibleIndex="3" Width="150px" >
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="BILLING_START_DATE" VisibleIndex="4" Width="150px">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="BILLING_FREQUENCY" VisibleIndex="5" Width="150px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="ENROLLED_PLANS" VisibleIndex="6" Width="150px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="COVERAGE_LEVEL" VisibleIndex="7" Width="150px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="STATUS" VisibleIndex="8">
                    </dx:GridViewDataTextColumn>
                
                    <dx:GridViewDataColumn Caption="PLAN_CATEGORY" VisibleIndex="9" Width="150px">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                            <asp:Label ID="lbl_PLAN_CATEGORY" runat="server" Text='<%#   Eval("EXPORT_2") %>'  ></asp:Label>

                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataTextColumn FieldName="BILLING_TYPE" VisibleIndex="10" Width="150px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="ACCOUNT_TYPE" VisibleIndex="11" Width="150px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="RATE_TYPE" VisibleIndex="12" Width="150px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="PREMIUM_DATE" VisibleIndex="12" Width="180px" FixedStyle="Left" Caption="Next Premium Due Date">
                    </dx:GridViewDataDateColumn>
                     <dx:GridViewDataColumn Caption="END DATE" VisibleIndex="13" Width="180px">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                          <dx:ASPxLabel ID="lbl_enddate" runat="server" Text='<%# string.IsNullOrEmpty(Eval("END_DATE").ToString()) ? "N/A":  Eval("END_DATE").ToString() %>'   Theme="Moderno"></dx:ASPxLabel>

                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Caption="Unallocated Amount($)" VisibleIndex="13" Width="180px">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                            <dx:ASPxLabel ID="lbl_UnallocatedAmount" runat="server" Text='<%# string.Format("{0:C}", Eval("UnallocatedAmount")) %>' DisplayFormatString="C" Theme="Moderno"></dx:ASPxLabel>

                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Caption="Member Owe($)" VisibleIndex="14" Width="150px">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                            <dx:ASPxLabel ID="lbl_MemberOwes" runat="server" Text='<%# string.Format("{0:C}", Eval("MemberOwes")) %>' DisplayFormatString="C" Theme="Moderno"></dx:ASPxLabel>

                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Caption="Current Premium Due($)" VisibleIndex="15" Width="180px">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                            <dx:ASPxLabel ID="lbl_Amount_Due" runat="server" Text='<%#Eval("EXPORT_2").ToString() =="Medical"? string.Format("{0:C}",Eval("AmountDue")) :string.Format("{0:C}", Eval("AmountDue")) %>' DisplayFormatString="C"></dx:ASPxLabel>

                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Caption="ADD TO FILE" VisibleIndex="16" Width="180px">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                          
                            <dx:ASPxButton ID="btn_add" runat="server" CommandArgument='<%#Eval("SSN") %>' CommandName="add" Text="Add To File"></dx:ASPxButton>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>

                </Columns>
            </dx:ASPxGridView>--%>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:FRS_Pen_ReductionConnectionString %>"
        SelectCommand="SELECT MEMBER_ID, FIRST, LAST, SSN, BILLING_START_DATE, BILLING_FREQUENCY, ENROLLED_PLANS, COVERAGE_LEVEL, STATUS, PREMIUM_DATE, BILLING_TYPE,
                ACCOUNT_TYPE, RATE_TYPE, UnallocatedAmount, LIFE, MEDICAL, MemberOwes, AMOUNT, AMOUNT_TYPE, END_DATE, PLAN_CATEGORY, CURRENT_DUE, FLAG, ID 
                FROM [dbo].[export_OCT2022] ORDER BY FIRST"
        UpdateCommand="UPDATE [dbo].[export_OCT2022] SET CURRENT_DUE = @CURRENT_DUE WHERE (ID = @ID)"
        DeleteCommand="DELETE FROM  [dbo].[export_OCT2022]  WHERE (ID = @ID)">
        <UpdateParameters>
            <asp:Parameter Name="CURRENT_DUE" />
            <asp:Parameter Name="ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>