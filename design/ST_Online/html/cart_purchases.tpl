<table class="purchase">
	<thead class="hidden-sm-down">
		<tr>
			<th data-language="cart_head_img">{$lang->cart_head_img}</th>
			<th class="text_left" data-language="cart_head_name">{$lang->cart_head_name}</th>
			<th data-language="cart_head_price">{$lang->cart_head_price}</th>
			<th data-language="cart_head_amoun">{$lang->cart_head_amoun}</th>
			<th data-language="cart_head_total">{$lang->cart_head_total}</th>
			<th></th>
		</tr>
	</thead>

	{foreach $cart->purchases as $purchase}
		<tr>
			{* Product image *}
			<td class="purchase_image">
				{$image = $purchase->product->images|first}
                <a class="image" href="{$lang_link}products/{$purchase->product->url}">
                    {if $image}	<img src="{$image->filename|resize:170:170}" alt="{$purchase->product->name|escape}" title="{$purchase->product->name|escape}">
                    {else}		<svg class="fn_img isvg" width="33" height="33">{include file='svg.tpl' item='isvg-noimage'}</svg>{/if}
                </a>
			</td>

			{* Product name *}
			<td class="purchase_name">
				<a href="{$lang_link}products/{$purchase->product->url}">{$purchase->product->name|escape}</a>
				{if $purchase->variant->name}<br /><i class="text-md">{$purchase->variant->name|escape}</i>{/if}
			</td>

			{* Price per unit *}
			<td class="purchase_price">
				<span class="text-nowrap">{($purchase->variant->price)|convert} {$currency->sign}</span>
			</td>

			{* Quantity *}
			<td class="purchase_amount">
				<div class="fn_product_amount{if $settings->is_preorder} fn_is_preorder{/if} amount">
					<span class="minus">&minus;</span>
					<input class="input_amount" type="text" data-id="{$purchase->variant->id}" name="amounts[{$purchase->variant->id}]" value="{$purchase->amount}" onblur="ajax_change_amount(this, {$purchase->variant->id});" data-max="{$purchase->variant->stock}">
					<span class="plus">&plus;</span>
				</div>
			</td>

			{* Extended price *}
			<td class="purchase_sum text-lg-right">
				<span class="text-nowrap text-bold">{($purchase->variant->price*$purchase->amount)|convert} {$currency->sign}</span>
			</td>

			{* Remove button *}
			<td class="purchase_remove">
				<a href="{$lang_link}cart/remove/{$purchase->variant->id}" onclick="ajax_remove({$purchase->variant->id});return false;" title="{$lang->cart_remove}">
					<svg class="isvg" width="24" height="24" style="color:red">{include file='svg.tpl' item='cart_remove'}</svg>
				</a>
			</td>
		</tr>
	{/foreach}

	{* Discount *}
	{if $user->discount}
		<tr>
			<td></td>
			<td colspan="3" class="text-bold" data-language="cart_discount">{*$lang->cart_discount*}Ваша скидка:</td>
			<td colspan="2" class="purchase_total text-md-right">{$user->discount}%</td>
		</tr>
	{/if}

	{* Coupon *}
	{if $coupon_request}
		{if $cart->coupon_discount > 0}
			<tr>
				<td></td>
				<td colspan="3" class="text-bold" data-language="cart_coupon">{$lang->cart_coupon}</td>
				<td colspan="2" class="purchase_total text-md-right">&minus; {$cart->coupon_discount|convert} {$currency->sign|escape}</td>
			</tr>
		{/if}
	{/if}

	<tfoot>
		<tr>
			<td colspan="3" class="coupon text_left py-2">
				{* Coupon *}
				{if $coupon_request}
					{* Coupon error messages *}
					{if $coupon_error}
						<div class="message_error">
							{if $coupon_error == 'invalid'}
								{$lang->cart_coupon_error}
							{/if}
						</div>
					{/if}
					{if $cart->coupon->min_order_price > 0}
						<div class="message_success">
							{$lang->cart_coupon} {$cart->coupon->code|escape} {$lang->cart_coupon_min} {$cart->coupon->min_order_price|convert} {$currency->sign|escape}
						</div>
					{/if}

					{* Coupon field *}
					<input class="fn_coupon input_coupon" type="text" name="coupon_code" value="{$cart->coupon->code|escape}" placeholder="{$lang->cart_coupon}">

					<input class="button coupon_button fn_sub_coupon" type="button" value="{$lang->cart_purchases_coupon_apply}">
				{/if}
			</td>

			<td colspan="3" class="purchase_total text-md-right">
				{* Total *}
				<span data-language="cart_total_price">{$lang->cart_total_price}:</span>
				<span class="total_sum text-nowrap">{$cart->total_price|convert} {$currency->sign|escape}</span>
			</td>
		</tr>
	</tfoot>
</table>