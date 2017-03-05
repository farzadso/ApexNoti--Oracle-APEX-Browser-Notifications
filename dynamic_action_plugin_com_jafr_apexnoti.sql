set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2016.08.24'
,p_release=>'5.1.0.00.45'
,p_default_workspace_id=>7970906592644076
,p_default_application_id=>159
,p_default_owner=>'ENG'
);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/shared_components/plugins/dynamic_action/com_jafr_apexnoti
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(35820004911023503)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'COM.JAFR.APEXNOTI'
,p_display_name=>'ApexNoti 1.0'
,p_category=>'NOTIFICATION'
,p_supported_ui_types=>'DESKTOP'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function render_apexNoti (',
'  p_dynamic_action in apex_plugin.t_dynamic_action,',
'  p_plugin         in apex_plugin.t_plugin',
'  ) return apex_plugin.t_dynamic_action_render_result ',
'is',
'  v_result apex_plugin.t_dynamic_action_render_result;',
'  ',
'  l_error varchar2(50) := p_dynamic_action.attribute_01; -- Error as Alert or Console Message',
'  l_title varchar2(100) := apex_escape.html(p_dynamic_action.attribute_02); -- Title of Notification',
'  l_icon varchar2(200) := apex_escape.html(p_dynamic_action.attribute_03); -- Icon on Notification',
'  l_body varchar2(500) := apex_escape.html(p_dynamic_action.attribute_04); -- Notification Body',
'  l_redirectLink varchar2(200) := apex_escape.html(p_dynamic_action.attribute_05); -- Link to Open',
'  l_timeOut varchar2(50) := apex_escape.html(p_dynamic_action.attribute_06); -- Timeout Seconds',
'  l_code varchar2(5000);',
'  ',
'  v_redirectLink varchar2(500); -- Temporary Variable for Redirect Code',
'  v_timeOut varchar2(200); -- Temporary Variable for Timeout Code',
'  ',
'begin',
'  l_code := ''function notifyMe() {',
'  if (!("Notification" in window)) {',
'    %ERROR%("This browser does not support system notifications");',
'  }',
'  else if (Notification.permission === "granted") {',
'    notify();',
'  }',
'  else if (Notification.permission !== "denied") {',
'    Notification.requestPermission(function (permission) {',
'      if (permission === "granted") {',
'        notify();',
'      }',
'    });',
'  }',
'  ',
'  function notify() {',
'    var notification = new Notification("%TITLE%", {',
'      icon: "%ICON%",',
'      body: "%BODY%",',
'    });',
'',
'    %REDIRECT%',
'	',
'    %TIMEOUT%',
'  }',
'',
'  }'';',
'  -- Print Error as an Alert or in the Console',
'  if l_error = ''ALERT'' then',
'    l_code := replace(l_code, ''%ERROR%'', ''alert'');',
'  elsif l_error = ''CONSOLE'' then',
'    l_code := replace(l_code, ''%ERROR%'', ''console.log'');',
'  end if;',
'  ',
'  -- Set TITLE',
'  l_code := replace(l_code, ''%TITLE%'', l_title);',
'  ',
'  -- Set ICON',
'  if l_icon is not null then',
'    l_code := replace(l_code, ''%ICON%'', l_icon);',
'  else',
'    l_icon := p_plugin.file_prefix || ''notification-icon.png'';',
'    l_code := replace(l_code, ''%ICON%'', l_icon);',
'  end if;',
'  -- Set Body Message',
'  l_code := replace(l_code, ''%BODY%'', l_body);',
'  ',
'  -- Set Redirect Link if Existant',
'  if l_redirectLink is not null then',
'    v_redirectLink := ''notification.onclick = function () {',
'      window.open("%LINK%");      ',
'    };'';',
'    v_redirectLink := replace(v_redirectLink, ''%LINK%'', l_redirectLink);',
'	l_code := replace(l_code, ''%REDIRECT%'', v_redirectLink);',
'  else',
'    l_code := replace(l_code, ''%REDIRECT%'', '' '');',
'  end if;',
'  ',
'  -- Set Timeout if Existant',
'  if l_timeOut is not null then',
'    v_timeOut := ''setTimeout(notification.close.bind(notification), %TIME%);'';',
'    v_timeOut := replace(v_timeOut, ''%TIME%'', l_timeOut);',
'	l_code := replace(l_code, ''%TIMEOUT%'', v_timeOut);',
'  else',
'    l_code := replace(l_code, ''%TIMEOUT%'', '' '');',
'  end if;',
'  ',
'  v_result.javascript_function := l_code;',
'  ',
'return v_result;',
'end render_apexNoti;',
'  '))
,p_api_version=>1
,p_render_function=>'render_apexNoti'
,p_standard_attributes=>'STOP_EXECUTION_ON_ERROR:WAIT_FOR_RESULT'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'This plugin uses the Notification API to show custom notifications. Your browser must support the notification API.',
'',
'Must browsers these days do. If your browser doesn''t you can choose to receive an error message either as an alert or in the console.',
'',
'For more information regarding the notifications interface refer to : https://developer.mozilla.org/en-US/docs/Web/API/notification'))
,p_version_identifier=>'1.0'
,p_about_url=>'http://farzadsoltani.com/2017/03/05/notifications-apexnoti-oracle-apex/'
,p_files_version=>2
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(35826031282084048)
,p_plugin_id=>wwv_flow_api.id(35820004911023503)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Error Type'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_default_value=>'ALERT'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'This option has two available types. If "Alert" is chosen and the plugin can''t run due to lack of support regarding the Notification API in your browser, you will receive a javascript alert that says your browser is unsupported. If "Console" is chose'
||'n, this message is printed in the console.log.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(35826643974085792)
,p_plugin_attribute_id=>wwv_flow_api.id(35826031282084048)
,p_display_sequence=>10
,p_display_value=>'Alert'
,p_return_value=>'ALERT'
,p_is_quick_pick=>true
,p_help_text=>'If chosen the error message will be rendered as a javascript alert message.'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(35827061564086858)
,p_plugin_attribute_id=>wwv_flow_api.id(35826031282084048)
,p_display_sequence=>20
,p_display_value=>'Console'
,p_return_value=>'CONSOLE'
,p_is_quick_pick=>true
,p_help_text=>'If chosen the error message will be rendered as a console.log message.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(35829055943198856)
,p_plugin_id=>wwv_flow_api.id(35820004911023503)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Title'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>true
,p_help_text=>'Sets the Title attribute for the Notification.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(11135973052531404)
,p_plugin_id=>wwv_flow_api.id(35820004911023503)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Icon'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Sets the icon for the notification. Without an icon it isn''t appealing. A default icon file has been added.',
'',
'The suitable size for your image file is 100x100 pixels with a white background (For chrome).',
'',
'You can also refer to files uploaded in Shared Components => Static Application Files.'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(35832093689261761)
,p_plugin_id=>wwv_flow_api.id(35820004911023503)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Body'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>true
,p_help_text=>'You can use this attribute to set the notification message also known as the body of the notification popup.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(22070418427610595)
,p_plugin_id=>wwv_flow_api.id(35820004911023503)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Link'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Set the link for the notification. This link is opened in a new tab when you click on the notification itself. ',
'',
'Just to be safe include "http://....." at the beginning of your link.'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(22071100305618590)
,p_plugin_id=>wwv_flow_api.id(35820004911023503)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Timeout'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_unit=>'milliseconds'
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Set this optional attribute for the timeout of the notification.',
'',
'For instance if you set it to 3000 milliseconds, the notification will fade away after 3 seconds.'))
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '89504E470D0A1A0A0000000D494844520000006400000064080600000070E29554000000206348524D00007A25000080830000F9FF000080E9000075300000EA6000003A980000176F925FC546000000097048597300000B1200000B1201D2DD7EFC0000';
wwv_flow_api.g_varchar2_table(2) := '001974455874536F667477617265007061696E742E6E657420342E302E313334035B7A00000F2449444154785EED9D0B7015E515C7B1B5D6BEA6ED4CAB9DDAA9B50FAD757888328A08421412C8852484475E3737098A8282B68C53A70F9D4EB5A5E380A2';
wwv_flow_api.g_varchar2_table(3) := '68ED43E56981505EA98006441E1A480810200414440C02111348C22398DD3DFD9FEF7E0949EE09B9AFDDBD2139333F2EB9BBFBEDF9CE7FBFE7FD76B7472C1B4D9CF8752B33F3262B2B2BC1F27A1F03B3C04AB0CDCACE3E046A40036567133E2D7CDFA0BE';
wwv_flow_api.g_varchar2_table(4) := 'F37A0FEA7D5680E72C9F6F2A3E87E1BB1BAD3163BEA693EFB68ECC9A32E5AB08DACD08DEA3A01070C02F70C0A301A785F4ABC11A88F4300B4463C75EA54FDF6D6C4A84ECEC4160360274109F96144C3BE073810338EF2C08340025F22BDAADAE65447405';
wwv_flow_api.g_varchar2_table(5) := '79BD3F064F201895C09402E624EC03C43982CF69565ADA0FA9478F2BB4BB97B791CF771B32BE089C9102130B40947A9498B9F0B19776FBF2327AEAA92F2193B72283AB62A134040BFC6D84BFF9564E4ECFCBA6C4A087740D32360F44AD71761A88721EBC';
wwv_flow_api.g_varchar2_table(6) := 'C679D1D9EA7C86AAE96ADD93A99732D919415EAA7161DDCF1D119DCDCE61565EDE4D68B0B74B99EAEC40101EEF6C4169B9416737768DEEB9E74A383C09C46C831D35BCDED3C8672EB78F3AFBB165A8A2BE832B271F38368E701BE495BBCAF330B8FCA60E';
wwv_flow_api.g_varchar2_table(7) := '436C18E5E6FE14CEED949CEE0A4094622B23E37A1D0E770D0DF79D70E873C9D1AE0462508976A5B70E8B3B062786815AC9C12E0AB72B4374789C3554511E9CFC9CE05497862F50C7458118F1B122464D66267D347EBCE234FE2FEDE334884F1D46F70375';
wwv_flow_api.g_varchar2_table(8) := 'B8EC35DD66B85E4D9DCCC8A08251A3E8F511235AB13A29896AB04D3AC64910A393E879F6D161B3C7746FAA5A72C0493E43C0E727260688D1C4426CAB8E0D512AC1753A7CD135F4B5BF8DC4774827769246AF97968D1CD91CFCB9804BCA2A30477FC7F0DF';
wwv_flow_api.g_varchar2_table(9) := 'F0574CC349700117F12F9F3A8CD1313D025F249DD0698EA5A7B712E353FCCD81672AD3D2D4774DDBABB04D4AC36920CA6B511DD123C1C9202646E0E563C73607FCEDE4E456DB58943568439AB6F3BE2DB7BB05FCE2697CAF0E67648686E997483066E6A6';
wwv_flow_api.g_varchar2_table(10) := '2A72C7D09B8F2552C9CB1EFA243F89A83895A83C8568CF68A2A2543ABC38898A677BA8E09144AAC81923A6E1061C43F4BC7EA1C31A9EF10A0D24542A9DC05172C07434D208B8751CA5A21642B4C7E924B2AA415512190793C85C83639EC0B1BE3669BA00';
wwv_flow_api.g_varchar2_table(11) := '4AC906545D57EAF0866E5656D6542961C7C80333D10E1C40099082AF6101CC6310E0F0286AFC001C08C458379AAC27DD150617374FDDE7E9F08666565ADAB538B84E4AD8111ECB22DA816A0857BC2402637D7E691102A88030AB50C53DE895CFE90010A5';
wwv_flow_api.g_varchar2_table(12) := 'C6CACDFDBE0E7370A67E03E76965214147780EA5E244FB55935503218E08010F12A32499AC3FB8374EC185FE6248BFD15B99997D2188F3BF817375326F3CD1A9B622B03868A06B5354DB107489B814E510F66F69B21F3683D89EE341B60E77C786030AA4';
wwv_flow_api.g_varchar2_table(13) := '846C87C5685B45D52168170A88CC6AB2EA97CBC10D175461D6B32E89E2F5E6EB705FDAD4BA293796EABC80C00488816AC538404D669D2991031B097B51525CA8BE10E3F3A8897EA5C32E1BF27C054A87F323F26968C0AB8436E3C232BF12CA2C328E3D2B';
wwv_flow_api.g_varchar2_table(14) := '07355276E25C93E183E49B8D40945774E865E3E59D10C4D941E004C083BAB662D462946D35348B61D56D46F0D07E48018D02AAF7E5709718B1AEA58C8CEFEAF0071AAFB5950EB495D9A8AA02C40075684FAC73A091CC9A5568C853C540460D6E4F789C22';
wwv_flow_api.g_varchar2_table(15) := 'F968232825D374F85B9BBE15A0523AC83672C1E1F6077DE6512F351ECC94036803C646F8C2B30292AF368152B2475C758F0D831C6FCC9FC778431082E1419F14345BD9EF7C2941DC2F805BB40C170D5FBE241D601B5C5FEF92DA0E3F910CFC22C1F8AFF3';
wwv_flow_api.g_varchar2_table(16) := '13922808CF6819FC662524F04D331F4A3BDBC654F46A4ECA62F0C0302A83BF7028456F2FCFD9A915C47E5FAB91BBBA8FCFC13B9714CFB65F5D99275CA8AE5A603DEEEC6209157B9FEF275A0E555D3D2AED682B8BC7896230C6C772A09CC29C8D1E9EE4B3';
wwv_flow_api.g_varchar2_table(17) := '8D408347B41C4A904269275BD9C27353B2201D5657687C1BF78DC428DB438D7BC06E0F19658964EC4EF4FFCDF076DE4F3ABE03CC252EB423D9D94B9518EAD6E3ECEC1A69275BF940E8EEF2A4E2F19164EC4270B72690F9EE5032DFBE97AC8221642D1D44';
wwv_flow_api.g_varchar2_table(18) := 'F49FBB89E60F209A7B17D19C20E0FDE6617F1CC7C75BAB0693F9D6BD646E184A465102193B47F845AD80782D0431D6A0B321F96C23D0E0437547B06E3F9C9FD9ADD45325473D4465F144854388F207122D4400A5E0DA050BCC82B1581B21144432D6BB20';
wwv_flow_api.g_varchar2_table(19) := '082FAEE33BB4F04F82B483EDE02AA525B8E2A520B98CF51A2E0EC967BBF1F96E63417E2D6EB49B45A8828460C404AF0E967DB61B9F6F2237E8B3C58D76D32D4800D0E20516C49D1FA3BA050980B5E0195E776ECEEC16241068C125E46371A3DD740B1200';
wwv_flow_api.g_varchar2_table(20) := '6BC1CB444F491B6DE752822C1840D6E281642DBB477547ADD5716416FAC70FE6A66164BC17EF1F476C0325C3FD6C67D0656DFA7B1BE07DB02F1FA38EE534D6C4F9D3E4B49770375BE8E9B92508B46041D4F3A61C671932BD1CA2AC4717B3185DE08A048C';
wwv_flow_api.g_varchar2_table(21) := '4D12C93CDA7AD4EC0818D1370F46219CB504E322C9679B612DB8CA726711F5110C0A854570E671772716196383F3034386B5704F90A3F242385E122A05C949DC15C4AD2AAB3D413EEDC282E82ACBF98945A65B9000580B2E2187A58DB6D32D4800AC050B';
wwv_flow_api.g_varchar2_table(22) := '522C6DB49D76059183E4242E0A52CC82AC9436DA4E7B82B8D1ED6D838B82AC64415E9436DA4E770909005ACCE246DDF9DFD399F604A99483E4242E36EAF7B320C3A48DB6D3CE0D39C64772909CC4D89C22FB6C332821B7729575234471F627DCFBBD4435';
wwv_flow_api.g_varchar2_table(23) := '8162B8B25A516207FC717E4969ADBAD54DDF69EBECF3AE9ECE081083A75162A17428CA4791F51BC7D766ED6F5EE38B3F9CFB918A9790BE13B8042816DA8E9698AF8E93FDB709D4546F2831D8F0C76469275BF81DAEBCEA1662A064989FC841719532F8F6';
wwv_flow_api.g_varchar2_table(24) := 'B07337F1408387B41C10242BEBE72825F64F324E42DB71E8E27A2C755BF32121183102DFDB4E13EC5FE7CBB1B732337FA4E5E8C14FFAB94AD561C2CE51836F5BAB801828114A089756B7878AF11644996CAF2888FD9E80DBA4F1E52C69E788C9C509E78C';
wwv_flow_api.g_varchar2_table(25) := '27ABD23FE88BE512D12EA5C964CE48F3DF6024E5314210FB3F69192E1ABF3F03F558F46ED841E36D4D4FA7C69264399321D2503E92CE9579E8CC0E0FD59578E8F45650E4A153EFFBA9D902F4FF795B6DB187EA4B3DEA183E564A3364B62693F574BABF63';
wwv_flow_api.g_varchar2_table(26) := '22E5390C10F30670B396E1A271970B4A1D910E0A19386CCE1D1BDC62E7FD23E9428587CEEF4EA033A5F751EDB6C154F3DEDDF4F9C6FE54B5BE1F1D7FBB2F1D5BD38796E5C6D3C2D411B460F4709A9F329CE6256946F999AB3F15F87E7EF270B52F1F5330';
wwv_flow_api.g_varchar2_table(27) := 'E93E95C609A4F519D2E4B4F91CB5C58321F07DEADC5FC007F645F4B12515E881FD0B3DB028898298EF4293F1652D436B8352D3A48342C542F196C4F802193EBF270157781C556FBE4B05FCD8DA3E74F47F3D3B64E5C4B8E6E76085CAEA2983C534DB726C';
wwv_flow_api.g_varchar2_table(28) := 'EDAD4AB09A2D03A87E7B9CF2957D6E9B0FCE1B977E29EFA1C20FF8D1E10F347EB30C4489EC6D060F7AA971778B11379C3FB73B5E09C057E9D1377B89C1E888A2BFF617831D0C5BA7F717D3EC10F8CA3EB3405C8A5A5D64DB93891E88ACB147AC4F597979';
wwv_flow_api.g_varchar2_table(29) := 'DFD2E10F346EE9A158440F9D3167A27468A72FEC4BA493EFDC216736440E2FED4D0B5212C4805F8A05A313E8E365BDC53443E5E4BB77F8AB369D3FEB2F91951208324B87BE7D439DD60B344A090403DF34D9E4F0E9F70789190B97225CE9AF27CA819798';
wwv_flow_api.g_varchar2_table(30) := 'E319412533A273413471BA685073FECC37C27F8420C4381BF413E6B0F35229916030D68E6E76B861CF703AFE565F3163E15059D09336FC7EA018FC0020DCA6A7EE56C748698503770A1ACA4734E7CF58992AC6201870D12FD4E1EED85429F17ACF4B0975';
wwv_flow_api.g_varchar2_table(31) := '84F9EF71CD0E33DC28726FA66ADDEDF4E9EA28541D0870F18C3B69D1F8785908B0387D18953E1F9D92C13E57ADEB4775C5435A37F0684FCC97C2BB1711F1AD0FE96D0AAA2DC9CE7E554AAC43F2BCEAB9212D456982DB14EE66566F1EE01728CC069E39B2';
wwv_flow_api.g_varchar2_table(32) := 'BC17ED7AB91F153E3E880A1E8A43D7368ED6FD761095FDBD1F1D59117EBAEC13FBC60DF9991D4395CF525E4CBE9F3DCC81222EF6993AD4C11B1AF76B7060784FB1CEC149D1F535B6A488996949C3DEE12AE35C8A4EE9F107773D4F14DEA6AA3BEE16F355';
wwv_flow_api.g_varchar2_table(33) := '1A89787C2CA7C169719A9C76D37884CF5987739FDD3914BE5CAC8E44502A8C4D29FE079F85390EC1855E15F223FE9A8CEFE84102E14F3AF2B4C9931964AC4089E1AE70CB6E63107015F14505E3515CD807508773DBC4DDD07365F18AB3BB86299AFEE6F1';
wwv_flow_api.g_varchar2_table(34) := '030BCDFBF2314DC7ABF4A471C5A5609F772591B13CD5FF5CAD087EB8C2056E5A3E5FA60E6FE80641AE8620EF498987CC042F597FCC50BF33188568F84BA333A5127558008C3178529147E44A8428CDF822966BF929E13ABCE119AAAE1B90D8E9B6894704';
wwv_flow_api.g_varchar2_table(35) := '1777AE7F1FCE22EB9974BF482845FC341EFEF95495A67250D12658D180D3DC8BB4CB002E0AE3DD145CFD635467C4FA33C615FC2033F62D8AF3550C4AC7A9A8BD1609CAE67271934E1475B84A7808A5E95188F578A62A553C4D61CE1A4FE63FC7A93932EE';
wwv_flow_api.g_varchar2_table(36) := 'FF9BF9635435A2842CD0F0DF80B7990BB1CF1CF00F1C332B4DA5A1D2E23491369FC3A9DFCD11BB465455A93A9C919B7E6CECEBD2C9BAE91808323BA4C7C20663A8BABE8184B74927ECA67D10B38DFCB4251DC6E89A9597773D4E70543A713781A056F910';
wwv_flow_api.g_varchar2_table(37) := '1DA31FE8F0D96338411F7ECBA5E4403717C185FB19B85187CD5E43F51507F5BB5F97D70E10A21AF4D7E172C694286E3EAC3F4651626465DDA1C3E4ACF1ABE15052BAFC5B3E9B402C4E3A5E32DA1AAE86DE70C4D9C7CBC620DC8047FC069D68199CB90E6C';
wwv_flow_api.g_varchar2_table(38) := '951CED0A20EF9BAC0913AED5E1880DE3710A9C9B03E7C2FEB5B1B381EA895FF6F5323F845A8721B64C8FE8B3419778C13D181BF511B81DC6752944590FDC7928818DA044986075CCBC3F3D58E36966CACACA8128EEDC076F03C84B15AAE6B488A7D0DD34';
wwv_flow_api.g_varchar2_table(39) := 'FE750C57D46C64A6D3BEEA1BBED783E7283DFD7B3A5B9DDBB89ED52F36CE07612D9E7003F87A16422CEC74D55328C6AFF941465F41466376EA05FE9D827F2FC4CCB8C209E337CB20E3D390F13DC0F9E706B7013EF02AF432CBE79B7AC9E59D97BBA955F7';
wwv_flow_api.g_varchar2_table(40) := '39393DD1859C8EA0EC078EF5CCF85C10612F3E9F06B774EAC6DA0ED3EBC17E86204D018BC107206A139848BB16EC479A6FE07312B70D9D621C112BA66EB5F3AF0FBB1D3C00668255A018013D844FAEEB5575874F039C0335F8FE20D886FFAF003390C604';
wwv_flow_api.g_varchar2_table(41) := 'B45D7DB9C727BE5E2866AC478FFF03425CA33EDEAAF9370000000049454E44AE426082';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(22062629533524906)
,p_plugin_id=>wwv_flow_api.id(35820004911023503)
,p_file_name=>'notification-icon.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
