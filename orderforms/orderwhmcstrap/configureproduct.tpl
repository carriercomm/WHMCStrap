{include file="orderforms/$carttpl/_includes/header.tpl" title=$LANG.cartproductconfig pageinfo=$LANG.cartproductdesc}

{include file="orderforms/$carttpl/verticalsteps.tpl" step=3}

<form method="post" action="{$smarty.server.PHP_SELF}?a=confproduct&i={$i}">
<input type="hidden" name="configure" value="true">

{if $errormessage}<div class="errorbox">{$errormessage|replace:'<li>':' &nbsp;#&nbsp; '} &nbsp;#&nbsp; </div><br />{/if}

<!--
<div class="orderbox">
<b class="orderboxrtop"><b class="r1"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b></b>
<div class="orderboxpadding">
<b>{$productinfo.groupname} - {$productinfo.name}</b><br />{$productinfo.description}
</div>
<b class="orderboxrbottom"><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r1"></b></b>
</div>
-->

{if $productinfo}
<div class="panel panel-primary">
	<input type="hidden" name="previousbillingcycle" value="{$billingcycle}" />

	<div class="panel-heading">
		<h3 class="panel-title">Billing Period</h3>
	</div>

  <div class="panel-body">
		<div class="well well-sm">
			<p style="margin-top:10px;">Pick how frequently you'd like to be billed. Longer billing periods mean bigger discounts, and other perks!</p>
		</div>
		
		{if $pricing.type eq "free"}
			<input type="hidden" name="billingcycle" value="free" />
			{$LANG.orderfree}
		{elseif $pricing.type eq "onetime"}
			<input type="hidden" name="billingcycle" value="onetime" />
			{$pricing.onetime} {$LANG.orderpaymenttermonetime}
		{else}
			<select class="form-control" name="billingcycle" onchange="submit()">
				{if $pricing.monthly}<option value="monthly"{if $billingcycle eq "monthly"} selected="selected"{/if}>{$pricing.monthly}</option>{/if}
				{if $pricing.quarterly}<option value="quarterly"{if $billingcycle eq "quarterly"} selected="selected"{/if}>{$pricing.quarterly}</option>{/if}
				{if $pricing.semiannually}<option value="semiannually"{if $billingcycle eq "semiannually"} selected="selected"{/if}>{$pricing.semiannually}</option>{/if}
				{if $pricing.annually}<option value="annually"{if $billingcycle eq "annually"} selected="selected"{/if}>{$pricing.annually}</option>{/if}
				{if $pricing.biennially}<option value="biennially"{if $billingcycle eq "biennially"} selected="selected"{/if}>{$pricing.biennially}</option>{/if}
				{if $pricing.triennially}<option value="triennially"{if $billingcycle eq "triennially"} selected="selected"{/if}>{$pricing.triennially}</option>{/if}
			</select>
		{/if}
  </div>

</div>
{/if}


{if $productinfo.type eq "server"}
<p><strong>{$LANG.cartconfigserver}</strong></p>
<div class="orderbox">
<table>
<tr><td>{$LANG.serverhostname}:</td><td><input type="text" name="hostname" size="15" value="{$server.hostname}" /> eg. server1(.yourdomain.com)</td></tr>
<tr><td>{$LANG.serverns1prefix}:</td><td><input type="text" name="ns1prefix" size="10" value="{$server.ns1prefix}" /> eg. ns1(.yourdomain.com)</td></tr>
<tr><td>{$LANG.serverns2prefix}:</td><td><input type="text" name="ns2prefix" size="10" value="{$server.ns2prefix}" /> eg. ns2(.yourdomain.com)</td></tr>
<tr><td>{$LANG.serverrootpw}:</td><td><input type="password" name="rootpw" size="20" value="{$server.rootpw}" /></td></tr>
</table>
</div>
{/if}

{if $configurableoptions}
<div class="panel panel-primary">

	<div class="panel-heading">
		<h3 class="panel-title">{$LANG.orderconfigpackage}</h3>
	</div>
	
	

	<div class="panel-body">
		<div class="well well-sm">
			<p style="margin-top:10px;">{$LANG.cartconfigoptionsdesc}</p>
		</div>
		
		<table>
			{foreach key=num item=configoption from=$configurableoptions}
			
			<tr><td>{$configoption.optionname}:</td><td>
			
			{if $configoption.optiontype eq 1}
			
			<select name="configoption[{$configoption.id}]">
				{foreach key=num2 item=options from=$configoption.options}
					<option value="{$options.id}"{if $configoption.selectedvalue eq $options.id} selected="selected"{/if}>{$options.name}</option>
				{/foreach}
			</select>
			
			{elseif $configoption.optiontype eq 2}
			
			{foreach key=num2 item=options from=$configoption.options}
			<label><input type="radio" name="configoption[{$configoption.id}]" value="{$options.id}"{if $configoption.selectedvalue eq $options.id} checked="checked"{/if}> {$options.name}</label><br />
			{/foreach}
			{elseif $configoption.optiontype eq 3}
			
			<label>
				<input type="checkbox" name="configoption[{$configoption.id}]" value="1"{if $configoption.selectedqty} checked{/if}> 
				{$configoption.options.0.name}
			</label>
			
			{elseif $configoption.optiontype eq 4}
			
			<input type="text" name="configoption[{$configoption.id}]" value="{$configoption.selectedqty}" size="5"> x {$configoption.options.0.name}
			
			
			{/if}
			</td></tr>
			{/foreach}
		</table>
	</div>

</div>
{/if}

{if $addons}
<div class="panel panel-primary">

	<div class="panel-heading">
		<h3 class="panel-title">{$LANG.orderchooseaddons}</h3>
	</div>
	
	<div class="panel-body">
		<div class="well well-sm">
			<p style="margin-top:10px;">{$LANG.orderaddondescription}</p>
		</div>
	
		{foreach key=num item=addon from=$addons}
		
		<label class="checkbox" for="a{$addon.id}">
			{$addon.checkbox} <h4 style="display:inline-block;">{$addon.name}</h4>
			<br>
			<span style="font-size:16px; margin-bottom:10px;" class="label label-success">{$addon.pricing}</span>
			<p style="margin-top:8px;">{$addon.description} </p>
		</label>
		
		<hr>
		{/foreach}
		
	</div>
	
</div>
{/if}

{if $customfields}
<p><strong>{$LANG.orderadditionalrequiredinfo}</strong></p>
<p>{$LANG.cartcustomfieldsdesc}</p>
<div class="orderbox">
<table>
{foreach key=num item=customfield from=$customfields}
<tr><td>{$customfield.name}:</td><td>{$customfield.input} {$customfield.description}</td></tr>
{/foreach}
</table>
</div>
{/if}

{if $domainoption}
<p><strong>{$LANG.cartproductdomain}</strong></p>

{if $domains}
<input type="hidden" name="domainoption" value="{$domainoption}" />
<p>
{foreach key=num item=domain from=$domains}
<input type="hidden" name="domains[]" value="{$domain.domain}" />
<input type="hidden" name="domainsregperiod[{$domain.domain}]" value="{$domain.regperiod}" />
{$LANG.orderdomain} {$num+1} - {$domain.domain}{if $domain.regperiod} ({$domain.regperiod} {$LANG.orderyears}){/if}<br />
{/foreach}
</p>
{/if}

{if $additionaldomainfields}
<table>
{foreach key=domainfieldname item=domainfield from=$additionaldomainfields}
<tr><td nowrap>{$domainfieldname}</td><td>{$domainfield}</td></tr>
{/foreach}
</table>
{/if}

{/if}

<p align="center">
{if $firstconfig}
	<input class="btn btn-primary" type="submit" value="{$LANG.addtocart}" />
{else}
	<input class="btn btn-primary" type="submit" value="{$LANG.updatecart}" />
{/if}
</p>

</form>

{include file="orderforms/$carttpl/_includes/footer.tpl"}