<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="TableEdit_FEB2022_.aspx.cs" Inherits="FRS_File_App.TableEdit_FEB_2022" %>
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
            <%--           <dx:ASPxFormLayout runat="server" ID="ASPxFormLayout" Width="100%" ClientInstanceName="FormLayout" Theme="Moderno">
                <Items>
                    <dx:LayoutGroup Width="100%" Caption="Search" ColCount="4">

                        <Items>--%>
            <%--      <dx:LayoutItem Caption="First Name" VerticalAlign="Middle">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxComboBox runat="server" ID="cmb_first" Theme="Moderno" AutoPostBack="True" 
                                            OnSelectedIndexChanged="cmb_first_OnSelectedIndexChanged" Width="100%">
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Insurance Type" VerticalAlign="Middle">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxComboBox runat="server" ID="cmb_type" Theme="Moderno" Width="100%" AutoPostBack="True" 
                                            OnSelectedIndexChanged="cmb_last_OnSelectedIndexChanged">
                                            <Items>
                                                <dx:ListEditItem Text="All" Value="0" Selected="True" />
                                                <dx:ListEditItem Text="Life" Value="1" />
                                                <dx:ListEditItem Text="Medical" Value="2" />
                                            </Items>
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>--%>
            <%--       <dx:LayoutItem Caption="Next Premium Due Date" VerticalAlign="Middle"  >
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                 
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>--%>
            <%--<dx:LayoutItem Caption="Last Name" VerticalAlign="Middle">

                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxComboBox runat="server" ID="cmb_last" Theme="Moderno" AutoPostBack="True" 
                                            OnSelectedIndexChanged="cmb_last_OnSelectedIndexChanged" Width="100%">
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="SSN" VerticalAlign="Middle">

                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxComboBox runat="server" ID="cmb_ssn" Theme="Moderno" AutoPostBack="True"
                                            OnSelectedIndexChanged="cmb_last_OnSelectedIndexChanged" Width="100%">
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="ENROLLED PLANS" VerticalAlign="Middle">

                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxComboBox runat="server" ID="cmb_ENROLLED_PLANS" Theme="Moderno" AutoPostBack="True"
                                            OnSelectedIndexChanged="cmb_last_OnSelectedIndexChanged" Width="100%">
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="COVERAGE LEVEL" VerticalAlign="Middle">

                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxComboBox runat="server" ID="cmb_COVERAGE_LEVEL" Theme="Moderno" AutoPostBack="True"
                                            OnSelectedIndexChanged="cmb_last_OnSelectedIndexChanged" Width="100%">
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="PLAN CATEGORY" VerticalAlign="Middle">

                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxComboBox runat="server" ID="cmb_PLAN_CATEGORY" Theme="Moderno" AutoPostBack="True"
                                            OnSelectedIndexChanged="cmb_last_OnSelectedIndexChanged" Width="100%">
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                     <dx:LayoutItem Caption="TOTAL AMOUNT DUE($)" VerticalAlign="Middle">

                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxComboBox runat="server" ID="cmb_TotalAmount" Theme="Moderno" AutoPostBack="True"
                                            OnSelectedIndexChanged="cmb_last_OnSelectedIndexChanged" Width="100%">
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Unallocated Amount" VerticalAlign="Middle">

                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                         <dx:ASPxComboBox runat="server" ID="cmb_unallocatedAmount" Theme="Moderno" Width="100%" AutoPostBack="True" OnSelectedIndexChanged="cmb_last_OnSelectedIndexChanged">
                                            <Items>
                                                <dx:ListEditItem Text="All" Value="0" Selected="True" />
                                                <dx:ListEditItem Text="> 0" Value="1" />
                                                <dx:ListEditItem Text="= 0" Value="2" />
                                            </Items>
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="Amount Due Status" VerticalAlign="Middle">

                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                         <dx:ASPxComboBox runat="server" ID="cmb_status" Theme="Moderno" Width="100%" 
                                             AutoPostBack="True" OnSelectedIndexChanged="cmb_last_OnSelectedIndexChanged">
                                            <Items>
                                                <dx:ListEditItem Text="All" Value="0" Selected="True" />
                                                <dx:ListEditItem Text="Total Due > Current Premium" Value="1" />
                                                <dx:ListEditItem Text="Total Due <= Current Premium" Value="2" />
                                                <dx:ListEditItem Text="Current Premium IS In The Future" Value="3" />
                                            </Items>
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                              <dx:LayoutItem Caption="PREMIUM END DATE" VerticalAlign="Middle">

                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                         <dx:ASPxComboBox runat="server" ID="cmb_enddate" Theme="Moderno" Width="100%" AutoPostBack="True" OnSelectedIndexChanged="cmb_last_OnSelectedIndexChanged">
                                            <Items>
                                                <dx:ListEditItem Text="All" Value="0" Selected="True" />
                                                <dx:ListEditItem Text="DOES NOT HAVE END DATE" Value="1" />
                                                <dx:ListEditItem Text="ENDED IN THE PAST" Value="2" />
                                                <dx:ListEditItem Text="ENDING IN THE FUTURE" Value="3" />
                                            </Items>
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                              <dx:LayoutItem Caption="SORT BY" VerticalAlign="Middle">

                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                         <dx:ASPxComboBox runat="server" ID="cmb_orderby" Theme="Moderno" Width="100%" AutoPostBack="True" OnSelectedIndexChanged="cmb_last_OnSelectedIndexChanged">
                                            <Items>
                                                <dx:ListEditItem Text="[MEMBER_ID]" Value="0" Selected="True" />
                                                <dx:ListEditItem Text="[FIRST]" Value="1" />
                                                <dx:ListEditItem Text="[LAST]" Value="2" />
                                                <dx:ListEditItem Text="[SSN]" Value="3" />
                                                <dx:ListEditItem Text="[PREMIUM_DATE]" Value="4" />
                                                <dx:ListEditItem Text="[CURRENT_DUE]" Value="5" /> 
                                            </Items>
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                               <dx:LayoutItem Caption="DESCENDING / ASCENDING" VerticalAlign="Middle">

                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                         <dx:ASPxComboBox runat="server" ID="cmb_ad" Theme="Moderno" Width="100%" AutoPostBack="True" OnSelectedIndexChanged="cmb_last_OnSelectedIndexChanged">
                                            <Items>
                                                <dx:ListEditItem Text="ASC" Value="0" Selected="True" />
                                                <dx:ListEditItem Text="DESC" Value="1" />
                                               
                                            </Items>
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>--%>
            <%--             <dx:LayoutItem ShowCaption="False" HorizontalAlign="Right" VerticalAlign="Middle" 
                                           Paddings-PaddingTop="20px" CssClass="lastItem" ColSpan="4">

                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                         

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                </Items>
            </dx:ASPxFormLayout> --%>
            <%--  <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" OnPageIndexChanged="ASPxGridView1_OnPageIndexChanged"
                Theme="Moderno"  OnRowCommand="ASPxGridView1_OnRowCommand" 
                Width="100%">
           
                <Settings HorizontalScrollBarMode="Visible" VerticalScrollableHeight="800" VerticalScrollBarMode="Auto" />
                <SettingsPager PageSize="1000" />
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
                            <asp:Label ID="lbl_PLAN_CATEGORY" runat="server" Text='<%#   Eval("PLAN_CATEGORY") %>'  ></asp:Label>

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
                            <dx:ASPxLabel ID="lbl_Amount_Due" runat="server" Text='<%#Eval("PLAN_CATEGORY").ToString() =="MEDICAL"? string.Format("{0:C}",Eval("MEDICAL")) :string.Format("{0:C}", Eval("LIFE")) %>' DisplayFormatString="C"></dx:ASPxLabel>

                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Caption="Total Amount Due($)" VisibleIndex="16" Width="180px">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                          
                                <dx:ASPxTextBox ID="lbl_Amount_Due2" runat="server" Width="100%" Theme="Moderno" Text='<%#Eval("CURRENT_DUE")  %>'>
                                    <MaskSettings Mask="<0..99999g>.<00..99>" ErrorText="Please input missing digits" />
                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" Display="Dynamic" ErrorTextPosition="Bottom" />
                                </dx:ASPxTextBox>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                      <dx:GridViewDataColumn Caption="EDIT" VisibleIndex="16" Width="150px">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                            <dx:ASPxButton ID="btn_edit" runat="server" Text="UPDATE" Theme="MaterialCompact" CommandName="edit"
                                    CommandArgument='<%# Eval("MEMBER_ID") %>'></dx:ASPxButton> 

                             
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                       <dx:GridViewDataColumn Caption="DELETE" VisibleIndex="16" Width="150px">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                             <dx:ASPxButton ID="btn_delete" runat="server" Text="DELETE" Visible='<%# int.Parse(Eval("FLAG").ToString()) == 4 ? true:false %>' Theme="Moderno" CommandName="delete"
                                    CommandArgument='<%# Eval("SSN") %>'></dx:ASPxButton>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                </Columns>
            </dx:ASPxGridView>--%>
           
            <div style="float:left;width:100%;margin-top:30px;margin-bottom:20px" class="page-header"> 
                       <dx:ASPxDateEdit ID="dateEdit" runat="server" EditFormat="Custom"   Enabled="false" Caption="PREMIUM DUE DATE"
                                            Theme="Moderno" Width="120px">
                                            <TimeSectionProperties>
                                                <TimeEditProperties EditFormatString="MM/dd/yyyy" />
                                            </TimeSectionProperties>
                                        </dx:ASPxDateEdit>
            </div>
             <div style="float:right">
                <dx:ASPxButton runat="server" ID="btn_archive" Text="Archive" 
                                             OnClick="btn_archive_OnClick" Theme="Moderno" ></dx:ASPxButton>
                                        &nbsp;&nbsp;
                                        <dx:ASPxButton runat="server" ID="btn_save" Text="Save All Changes" OnClick="btn_save_OnClick" Theme="MaterialCompact" ></dx:ASPxButton>
                                        &nbsp;&nbsp;
                                        <dx:ASPxButton runat="server" ID="btn_export_csv" Text="RAW DATA CSV" OnClick="btn_export_csv_OnClick" Theme="iOS"></dx:ASPxButton>
                                        &nbsp;&nbsp;<dx:ASPxButton runat="server" ID="btn_life" Text="LIFE CSV" OnClick="btn_life_OnClick" Theme="Moderno"></dx:ASPxButton>
                                        &nbsp;&nbsp;<dx:ASPxButton runat="server" ID="btn_medical" Text="MEDICAL CSV" OnClick="btn_medical_OnClick" Theme="Moderno"></dx:ASPxButton>
            </div>
            <%--Settings-VerticalScrollableHeight="600" Settings-HorizontalScrollBarMode="Auto" Settings-VerticalScrollBarMode="Visible" Settings-VerticalScrollBarStyle="Standard"--%>
            <dx:ASPxGridView ID="grid_view" runat="server" Width="100%" Theme="Moderno" AutoGenerateColumns="False"
                DataSourceID="datasource_grid" OnRowCommand="ASPxGridView1_OnRowCommand">
                <Settings VerticalScrollBarStyle="Standard" VerticalScrollableHeight="600" HorizontalScrollBarMode="Auto" VerticalScrollBarMode="Visible" ShowFilterRow="True"></Settings>
                <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                <Settings HorizontalScrollBarMode="Visible" VerticalScrollableHeight="800" VerticalScrollBarMode="Auto" />
                <SettingsPager PageSize="1000" />
                <Paddings Padding="0px" />
                <Border BorderWidth="0px" />
                <BorderBottom BorderWidth="1px" />
                <SettingsSearchPanel Visible="True" />
                <Columns>
                    <%--  <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                    </dx:GridViewCommandColumn>--%>
                    <dx:GridViewDataTextColumn FieldName="FIRST" VisibleIndex="1" FixedStyle="Left" Caption="FRIST NAME" HeaderStyle-HorizontalAlign="Center">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="LAST" VisibleIndex="2" FixedStyle="Left" Caption="LAST NAME">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="PREMIUM_DATE" VisibleIndex="3" Width="180px" FixedStyle="Left" Caption="Next Premium Due Date" HeaderStyle-HorizontalAlign="Center">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    </dx:GridViewDataDateColumn>
                 <%--   <dx:GridViewDataTextColumn FieldName="MEMBER_ID" VisibleIndex="4" Width="150px" Caption="MEMBER ID" HeaderStyle-HorizontalAlign="Center">
                    </dx:GridViewDataTextColumn>--%>
                     <dx:GridViewDataColumn Caption="MEMBER_ID" VisibleIndex="0" Width="150px" FieldName="MEMBER_ID" HeaderStyle-HorizontalAlign="Center">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                            <asp:Label ID="lbl_MEMBER_ID" runat="server" Text='<%#   Eval("MEMBER_ID") %>'  ></asp:Label>

                        </DataItemTemplate>

<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataTextColumn FieldName="SSN" VisibleIndex="5" Width="150px" HeaderStyle-HorizontalAlign="Center">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="BILLING_START_DATE" VisibleIndex="6" Width="150px" Caption="BILLING START DATE" HeaderStyle-HorizontalAlign="Center">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="BILLING_FREQUENCY" VisibleIndex="7" Width="150px" Caption="BILLING FREQUENCY" HeaderStyle-HorizontalAlign="Center">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="ENROLLED_PLANS" VisibleIndex="8" Width="150px" Caption="ENROLLED PLAN" HeaderStyle-HorizontalAlign="Center">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="COVERAGE_LEVEL" VisibleIndex="9" Width="150px" Caption="COVERAGE LEVEL" HeaderStyle-HorizontalAlign="Center">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="STATUS" VisibleIndex="10" Width="150px" Caption="STATUS" HeaderStyle-HorizontalAlign="Center">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    </dx:GridViewDataTextColumn>
              <%--      <dx:GridViewDataTextColumn FieldName="PLAN_CATEGORY" VisibleIndex="11" Width="150px" Caption="PLAN CATEGORY" HeaderStyle-HorizontalAlign="Center">
                    </dx:GridViewDataTextColumn>--%>
                       <dx:GridViewDataColumn Caption="PLAN_CATEGORY" VisibleIndex="11" Width="150px" FieldName="PLAN_CATEGORY" HeaderStyle-HorizontalAlign="Center">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                            <asp:Label ID="lbl_PLAN_CATEGORY" runat="server" Text='<%#   Eval("PLAN_CATEGORY") %>'  ></asp:Label>

                        </DataItemTemplate>

<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataTextColumn FieldName="BILLING_TYPE" VisibleIndex="12" Width="150px" Caption="BILLING TYPE" HeaderStyle-HorizontalAlign="Center">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="ACCOUNT_TYPE" VisibleIndex="13" Width="150px" Caption="ACCOUNT TYPE" HeaderStyle-HorizontalAlign="Center">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="RATE_TYPE" VisibleIndex="14" Width="150px" Caption="RATE TYPE" HeaderStyle-HorizontalAlign="Center">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="END_DATE" VisibleIndex="15" Width="150px" Caption="END DATE" HeaderStyle-HorizontalAlign="Center">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="UnallocatedAmount" VisibleIndex="16" Width="180px" Caption="UNALLOCATED AMOUNT($)" HeaderStyle-HorizontalAlign="Center">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="MemberOwes" VisibleIndex="17" Width="180px" Caption="PREVIOUS OWES($)" HeaderStyle-HorizontalAlign="Center">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataColumn Caption="CURRENT PREMIUM DUE($)" VisibleIndex="18" Width="200px" HeaderStyle-HorizontalAlign="Center">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                            <dx:ASPxLabel ID="lbl_Amount_Due" runat="server" Text='<%#Eval("PLAN_CATEGORY").ToString() =="MEDICAL"? string.Format("{0:C}",Eval("MEDICAL")) :string.Format("{0:C}", Eval("LIFE")) %>' DisplayFormatString="C"></dx:ASPxLabel>

                        </DataItemTemplate>

<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Caption="TOTAL AMOUNT DUE ($)" VisibleIndex="19" Width="180px" FieldName="CURRENT_DUE" HeaderStyle-HorizontalAlign="Center">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>

                            <dx:ASPxTextBox ID="lbl_Amount_Due2" runat="server" Width="100%" Theme="Moderno" Text='<%#Eval("CURRENT_DUE")  %>'>
                                <MaskSettings Mask="<0..99999g>.<00..99>" ErrorText="Please input missing digits" />
                                <ValidationSettings ErrorDisplayMode="ImageWithTooltip" Display="Dynamic" ErrorTextPosition="Bottom" />
                            </dx:ASPxTextBox>
                        </DataItemTemplate>

<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    </dx:GridViewDataColumn>
                    <%--    <dx:GridViewDataTextColumn FieldName="CURRENT_DUE" VisibleIndex="19" Width="150px">
                    </dx:GridViewDataTextColumn>--%>

                    <dx:GridViewDataColumn Caption="EDIT" VisibleIndex="20" Width="150px">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                            <dx:ASPxButton ID="btn_edit" runat="server" Text="UPDATE" Theme="MaterialCompact" CommandName="edit"
                                CommandArgument='<%# Eval("MEMBER_ID") %>'>
                            </dx:ASPxButton>


                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Caption="DELETE" VisibleIndex="21" Width="150px">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                            <dx:ASPxButton ID="btn_delete" runat="server" Text="DELETE" Visible='<%# int.Parse(Eval("FLAG").ToString()) == 4 ? true:false %>' Theme="Moderno" CommandName="delete"
                                CommandArgument='<%# Eval("SSN") %>'>
                            </dx:ASPxButton>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                </Columns>
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="datasource_grid" runat="server" ConnectionString="<%$ ConnectionStrings:FRS_Pen_ReductionConnectionString %>" 
                SelectCommand="SELECT [FIRST], [LAST], [PREMIUM_DATE], [MEMBER_ID], [SSN], [BILLING_START_DATE], [BILLING_FREQUENCY], [ENROLLED_PLANS], [COVERAGE_LEVEL], [STATUS], [PLAN_CATEGORY], [BILLING_TYPE], [ACCOUNT_TYPE], [RATE_TYPE], [END_DATE], [UnallocatedAmount], [MemberOwes], [AMOUNT], [CURRENT_DUE], [LIFE], [MEDICAL], [FLAG] FROM [dbo].[export_FEB2022] ORDER BY [FIRST]"></asp:SqlDataSource>
            <div style="width:100%;text-align:center;font-weight:bold;margin-top:30px" class="text-primary">
                <h4>ENDED IN THE PAST</h4>
            </div>
            <div style="width:100%;text-align:right">
                  <dx:ASPxButton ID="btn_add" runat="server" Theme="Moderno" Text="ADD TO CURRENT MONTH" onclick="btn_add_OnClick"></dx:ASPxButton>
            </div>
            <br /><br />
            <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False"  
                OnPageIndexChanged="ASPxGridView1_OnPageIndexChanged" Theme="Moderno" OnRowCommand="ASPxGridView1_OnRowCommand" 
                Width="100%">
                <%--  <SettingsAdaptivity AdaptivityMode="HideDataCells" />--%>
                <Settings HorizontalScrollBarMode="Visible" VerticalScrollableHeight="300" VerticalScrollBarMode="Auto" />
                <SettingsPager PageSize="100" />
                <Paddings Padding="0px" />
                <Border BorderWidth="0px" />
                <BorderBottom BorderWidth="1px" />
                <%-- DXCOMMENT: Configure ASPxGridView's columns in accordance with datasource fields --%>
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
                            <asp:Label ID="lbl_PLAN_CATEGORY" runat="server" Text='<%#   Eval("PLAN_CATEGORY") %>'  ></asp:Label>

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
                            <dx:ASPxLabel ID="lbl_Amount_Due" runat="server" Text='<%#Eval("PLAN_CATEGORY").ToString() =="MEDICAL"? string.Format("{0:C}",Eval("MEDICAL")) :string.Format("{0:C}", Eval("LIFE")) %>' DisplayFormatString="C"></dx:ASPxLabel>

                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Caption="Total Amount Due($)" VisibleIndex="16" Width="180px">
                        <SettingsHeaderFilter>
                            <DateRangePickerSettings EditFormatString=""></DateRangePickerSettings>
                        </SettingsHeaderFilter>
                        <DataItemTemplate>
                          
                                <dx:ASPxTextBox ID="lbl_Amount_Due2" Enabled="False" runat="server" Width="100%" Theme="Moderno" Text='<%#Eval("CURRENT_DUE")  %>'>
                                    <MaskSettings Mask="<0..99999g>.<00..99>" ErrorText="Please input missing digits" />
                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" Display="Dynamic" ErrorTextPosition="Bottom" />
                                </dx:ASPxTextBox>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>

                </Columns>
            </dx:ASPxGridView>


         

             <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FRS_Pen_ReductionConnectionString %>" SelectCommand="SELECT [MEMBER_ID], [FIRST], [LAST], [SSN], [BILLING_START_DATE], [BILLING_FREQUENCY], [ENROLLED_PLANS], [COVERAGE_LEVEL], [STATUS], [PREMIUM_DATE], [BILLING_TYPE], [ACCOUNT_TYPE], [RATE_TYPE], [UnallocatedAmount], [LIFE], [MEDICAL], [MemberOwes], [AMOUNT], [AMOUNT_TYPE], [END_DATE], [PLAN_CATEGORY], [CURRENT_DUE] FROM [export_FEB2022] ORDER BY [FIRST]"></asp:SqlDataSource>
           




              <div style="height:30px;width:100%"> </div>
                 
        </div>
        <div class="col-sm-1"></div>
    </div>
    
</asp:Content>
