{include file="overall_header.tpl"}
{include file="overall_topnav.tpl"}
{include file="left_menu.tpl"}
<div id="content" class="content">
    <table style="min-width:519px;width:519px;">
        <tr>
        	<th colspan="4"><a href="javascript:$('.containerPlus').mb_open();" title="{$ov_planetmenu}">{$ov_planet} "<span class="planetname">{$planetname}</span>"</a> ({$username})</th>
        </tr>
        {if $messages}
		<tr>
			<td colspan="4"><a href="?page=messages">{$messages}</a></td>
		</tr>
		{/if}
        <tr>
        	<td>{$ov_server_time}</td>
        	<td colspan="3" id="servertime"></td>
        </tr>
		{if $is_news}
		<tr>
			<td>{$ov_news}</td><td colspan="3">{$news}</td>
		</tr>
		{/if}
        <tr>
        	<td style="white-space: nowrap;">{$ov_admins_online}</td>
        	<td colspan="3">{foreach name=OnlineAdmins key=id item=Name from=$AdminsOnline}{if !$smarty.foreach.OnlineAdmins.first}&nbsp;&bull;&nbsp;{/if}<a href="javascript:f('game.php?page=messages&amp;mode=write&amp;id={$id}','');">{$Name}</a>{foreachelse}{$ov_no_admins_online}{/foreach}</td>
        </tr>		
		{if $Teamspeak}
		<tr>
			<td>{$ov_teamspeak}</td><td colspan="3">{$Teamspeak}</td>
		</tr>
		{/if}
        <tr>
        	<th colspan="4">{$ov_events}</th>
        </tr>
        {foreach item=FleetInfoRow from=$fleets}
		<tr class="{$FleetInfoRow.fleet_status}">
			<td>
			{$FleetInfoRow.fleet_javai}
				<div id="bxx{$FleetInfoRow.fleet_order}" class="z">-</div>
			</td><td colspan="3">
				{$FleetInfoRow.fleet_descr}
			{$FleetInfoRow.fleet_javas}
			</td>
		</tr>
		{/foreach}
        <tr>
        	<td>{if $Moon}<a href="game.php?page=overview&amp;cp={$Moon.id}&amp;re=0" title="{$Moon.name}"><img src="{$dpath}planeten/mond.jpg" height="50" width="50" alt="{$Moon.name} ({$fcm_moon})"></a><br>{$Moon.name} ({$fcm_moon}){else}&nbsp;{/if}</td>
        	<td colspan="2"><img src="{$dpath}planeten/{$planetimage}.jpg" height="200" width="200" alt="{$planetname}"><br>{$build}</td>
        	<td>
            {if $AllPlanets}
			<table>
				{foreach name=PlanetList item=PlanetRow from=$AllPlanets}
				{if $smarty.foreach.PlanetList.iteration is odd}<tr style="height:20px;">{/if}			
				<td class="transparent">{$PlanetRow.name}<br><a href="game.php?page=overview&amp;cp={$PlanetRow.id}&amp;re=0" title="{$PlanetRow.name}"><img src="{$dpath}planeten/small/s_{$PlanetRow.image}.jpg" alt="{$PlanetRow.name}"></a><br>{$PlanetRow.build}</td>
				{if $smarty.foreach.PlanetList.last && $smarty.foreach.PlanetList.total is odd && $smarty.foreach.PlanetList.total != 1}<td class="transparent">&nbsp;</td>{/if}
				{if $smarty.foreach.PlanetList.iteration is even}</tr>{/if}
				{/foreach}
			</table>
			{else}&nbsp;{/if}
            </td>
        </tr>
        <tr>
            <td>{$ov_diameter}</td>
            <td colspan="3">{$planet_diameter} {$ov_distance_unit} (<a title="{$ov_developed_fields}">{$planet_field_current}</a> / <a title="{$ov_max_developed_fields}">{$planet_field_max}</a> {$ov_fields})</td>
        </tr>
        <tr>
            <td>{$ov_temperature}</td>
            <td colspan="3">{$ov_aprox} {$planet_temp_min}{$ov_temp_unit} {$ov_to} {$planet_temp_max}{$ov_temp_unit}</td>
        </tr>
        <tr>
            <td>{$ov_position}</td>
            <td colspan="3"><a href="game.php?page=galaxy&amp;mode=0&amp;galaxy={$galaxy}&amp;system={$system}">[{$galaxy}:{$system}:{$planet}]</a></td>
        </tr>
        <tr>
            <td>{$ov_points}</td>
            <td colspan="3">{$user_rank}</td>
        </tr>
		{if !CheckModule(37)}
		<tr>
			<th colspan="4">{$ov_userbanner}</th>
		</tr>
		<tr>
			<td colspan="4"><img src="userpic.php?id={$userid}" alt="" height="80" width="450"><br><br><table><tr><td class="transparent">HTML:</td><td class="transparent"><input type="text" value='<a href="http://{$smarty.server.SERVER_NAME}{$patd}"><img src="http://{$smarty.server.SERVER_NAME}{$patd}userpic.php?id={$userid}"></a>' readonly="readonly" style="width:450px;"></td></tr><tr><td class="transparent">BBCode:</td><td class="transparent"><input type="text" value="[url='http://{$smarty.server.SERVER_NAME}{$patd}'][img]http://{$smarty.server.SERVER_NAME}{$patd}userpic.php?id={$userid}[/img][/url]" readonly="readonly" style="width:450px;"></td></tr></table></td>
		</tr>
		{/if}
   </table>
	<script type="text/javascript">
	Servertime(ctimestamp);
	$(function(){
      $(".containerPlus").buildContainers({
        containment:"document",
        elementsPatd:"styles/css/mbContainer/",
        onClose:function(o){},
        effectDuration:500,
		slideTimer:300,
        autoscroll:true,
      });
	});

	function checkrename()
	{
		if($('#newname').val() == '') {
			return false;
		} else {
			$.post('game.php?page=overview&mode=renameplanet&ajax=1', $('#rename').serialize(), function(response){
				if(response == '') {
					$('.planetname').text($('#newname').val());
					$('#demoContainer').mb_close();
				} else {
					alert(response);
				}
			});
			return false;
		}
	}

	function checkcancel()
	{
		if($('#password').val() == '') {
			return false;
		} else {
			$.post('game.php?page=overview&mode=deleteplanet&ajax=1', $('#rename').serialize(), function(response){
				if(response == '') {
					alert('{$ov_planet_abandoned}');
					document.location.href = 'game.php?page=overview';
				} else {
					alert(response);
				}
			});
			return false;
		}
	}
	
	function cancel()
	{
		$('#submit-rename').hide();
		$('#submit-cancel').show();
		$('#label').text('{$ov_password}');
		$('#newname').hide();
		$('#password').show();
	}
</script>
</div>
  <div id="demoContainer" class="containerPlus draggable resizable { buttons:'c', skin:'black', width:'580', height:'200',dock:'dock',closed:'true'}" style="position:absolute;top:250px;left:400px; height:50%">
    <div class="no"><div class="ne"><div class="n">{$ov_planet_rename_action}</div></div>
      <div class="o"><div class="e"><div class="c">
        <div class="mbcontainercontent">
          	<form action="" method="POST" id="rename">
			<table>
			<tr>
				<th colspan="3">{$ov_your_planet}</th>
			</tr><tr>
				<td>{$ov_coords}</td>
				<td>{$ov_planet_name}</td>
				<td>{$ov_actions}</td>
			</tr><tr>
				<td>{$galaxy}:{$system}:{$planet}</td>
				<td>{$planetname}</td>
				<td><input type="button" value="{$ov_abandon_planet}" onclick="cancel();"></td>
			</tr><tr>
				<td id="label">{$ov_planet_rename}</td>
				<td><input type="text" name="newname" id="newname" size="25" maxlength="20"><input type="password" name="password" id="password" size="25" maxlength="20" style="display:none;"></td>
				<td><input type="button" onclick="checkrename();" value="{$ov_planet_rename_action}" id="submit-rename"><input type="button" onclick="checkcancel();" value="{$ov_delete_planet}" id="submit-cancel" style="display:none;"></td>
			</tr>
			</table>
			</form>
        </div>
      </div></div></div>
      <div >
        <div class="so"><div class="se"><div class="s"> </div></div></div>
      </div>
    </div>
  </div>
{include file="planet_menu.tpl"}
{include file="overall_footer.tpl"}