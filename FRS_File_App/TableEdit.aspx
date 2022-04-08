<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="TableEdit.aspx.cs" Inherits="FRS_File_App.TableEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    
    
        <script type="text/javascript">
        function popupwindow(url, title, w, h) {
            var left = (screen.width / 2) - (w / 2);
            var top = (screen.height / 2) - (h / 2);
            return window.open(url, title, 'toolbar=no, location=no, directories=no, status=no,      menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
        }
    </script>

    <div class="row">
        <div class="col-sm-1"></div>
        <div class="col-sm-10">
            <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout" Width="100%" ClientInstanceName="FormLayout" Theme="Moderno">
                <Items>
                    <dx:LayoutGroup Width="100%" Caption="Search" ColCount="2">

                        <Items>
                            <dx:LayoutItem Caption="Insurance Type" VerticalAlign="Middle">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxComboBox runat="server" ID="cmb_type" Theme="Moderno">
                                            <Items>
                                                <dx:ListEditItem Text="All" Value="0" Selected="True" />
                                                <dx:ListEditItem Text="Life" Value="1" />
                                                <dx:ListEditItem Text="Medical" Value="2" />
                                            </Items>
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Premium Due Date" VerticalAlign="Middle"  >
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxDateEdit ID="dateEdit" runat="server" EditFormat="Custom"  Theme="Moderno" Enabled="False" Date="11/01/2021">
                                            <TimeSectionProperties>
                                                <TimeEditProperties EditFormatString="MM/dd/yyyy" />
                                            </TimeSectionProperties>
                                        </dx:ASPxDateEdit>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="First Name" VerticalAlign="Middle">

                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxComboBox runat="server" ID="cmb_first" Theme="Moderno" AutoPostBack="True" 
                                            OnSelectedIndexChanged="cmb_first_OnSelectedIndexChanged">
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="Last Name" VerticalAlign="Middle">

                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxComboBox runat="server" ID="cmb_last" Theme="Moderno" AutoPostBack="True" 
                                            OnSelectedIndexChanged="cmb_last_OnSelectedIndexChanged">
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
              





                            <dx:LayoutItem ShowCaption="False" HorizontalAlign="Right" VerticalAlign="Middle" 
                                           Paddings-PaddingTop="20px" CssClass="lastItem" ColSpan="2">

                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxButton runat="server" ID="btn_save" Text="Save All Changes" OnClick="btn_save_OnClick" Theme="Moderno" Enabled="false"></dx:ASPxButton>
                                        &nbsp;&nbsp;
                                        <dx:ASPxButton runat="server" ID="btn_export_csv" Text="RAW DATA CSV" OnClick="btn_export_csv_OnClick" Theme="Moderno"></dx:ASPxButton>
                                        &nbsp;&nbsp;<dx:ASPxButton runat="server" ID="btn_life" Text="LIFE CSV" OnClick="btn_life_OnClick" Theme="Moderno"></dx:ASPxButton>
                                        &nbsp;&nbsp;<dx:ASPxButton runat="server" ID="btn_medical" Text="MEDICAL CSV" OnClick="btn_medical_OnClick" Theme="Moderno"></dx:ASPxButton>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                </Items>
            </dx:ASPxFormLayout> 
          
       
          
       
            <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" OnPageIndexChanged="ASPxGridView1_OnPageIndexChanged" Theme="Moderno"
                Width="100%">
                <%--  <SettingsAdaptivity AdaptivityMode="HideDataCells" />--%>
                <Settings HorizontalScrollBarMode="Visible" VerticalScrollableHeight="400" VerticalScrollBarMode="Auto" />
                <SettingsPager PageSize="100" />
                <Paddings Padding="0px" />
                <Border BorderWidth="0px" />
                <BorderBottom BorderWidth="1px" />
                <%-- DXCOMMENT: Configure ASPxGridView's columns in accordance with datasource fields --%>
                <Columns>
               <%--     <dx:GridViewDataTextColumn FieldName="MEMBER_ID" VisibleIndex="0" FixedStyle="Left">
                    </dx:GridViewDataTextColumn>--%>
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
                    <dx:GridViewDataTextColumn FieldName="SSN" VisibleIndex="3" Width="150px" FixedStyle="Left">
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
                  <%--  <dx:GridViewDataTextColumn FieldName="PLAN_CATEGORY" VisibleIndex="10" Width="150px">
                    </dx:GridViewDataTextColumn>--%>
                    <dx:GridViewDataColumn Caption="PLAN_CATEGORY" VisibleIndex="10" Width="150px">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                            <asp:Label ID="lbl_PLAN_CATEGORY" runat="server" Text='<%#   Eval("PLAN_CATEGORY") %>'  ></asp:Label>

                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataTextColumn FieldName="BILLING_TYPE" VisibleIndex="10" Width="150px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="ACCOUNT_TYPE" VisibleIndex="11" Width="150px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="RATE_TYPE" VisibleIndex="12" Width="150px">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="PREMIUM_DATE" VisibleIndex="12" Width="250px" Caption="Next Premium Due Date">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataColumn Caption="Unallocated Amount($)" VisibleIndex="13" Width="150px">
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
                    <dx:GridViewDataColumn Caption="Current Premium Due($)" VisibleIndex="15" Width="150px">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                            <dx:ASPxLabel ID="lbl_Amount_Due" runat="server" Text='<%#Eval("PLAN_CATEGORY").ToString() =="MEDICAL"? string.Format("{0:C}",Eval("MEDICAL")) :string.Format("{0:C}", Eval("LIFE")) %>' DisplayFormatString="C"></dx:ASPxLabel>

                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Caption="Total Amount Due($)" VisibleIndex="16" Width="150px">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                            <%--<dx:ASPxLabel ID="lbl_Amount_Due" runat="server" Text='<%#Eval("PLAN_CATEGORY").ToString() =="MEDICAL"? string.Format("{0:C}",Eval("MEDICAL")) :string.Format("{0:C}", Eval("LIFE")) %>' DisplayFormatString="C"></dx:ASPxLabel>--%>
                            <asp:TextBox ID="lbl_Amount_Due2" runat="server" Text='<%#Eval("CURRENT_DUE")  %>'  ></asp:TextBox>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>

                </Columns>
            </dx:ASPxGridView>

        </div>
        <div class="col-sm-1"></div>
    </div>
    

</asp:Content>
