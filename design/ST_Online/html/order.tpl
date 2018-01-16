{* Order page *}

{* The page title *}
{$meta_title = "`$lang->email_order_title` `$order->id`" scope=parent}

{* The page heading *}
<div class="page_header" data-language="order_header">
{$lang->order_header} {$order->id} / {$order_status->name|escape}
</div>

{if $payment_methods && !$payment_method && $order->total_price>0}
{elseif $payment_method}
<table class="purchase">
	<thead class="hidden-sm-down">
		<tr>
			<th data-language="cart_head_img">{$lang->cart_head_img}</th>
			<th class="text-left" data-language="cart_head_name">{$lang->cart_head_name}</th>
			<th data-language="cart_head_price">{$lang->cart_head_price}</th>
			<th data-language="cart_head_amoun">{$lang->cart_head_amoun}</th>
			<th data-language="cart_head_total">{$lang->cart_head_total}</th>
		</tr>
	</thead>

	{foreach $purchases as $purchase}
		<tr>
			{* Product image *}
			<td class="purchase_image">
				{$image = $purchase->product->images|first}
				<a class="image" href="{$lang_link}products/{$purchase->product->url}">
					{if $image}	<img src="{$image->filename|resize:50:50}" alt="{$purchase->product_name|escape}" title="{$purchase->product_name|escape}">
					{else}		<svg class="fn_img isvg" width="33" height="33">{include file='svg.tpl' item='isvg-noimage'}</svg>{/if}
				</a>
			</td>

			{* Product name *}
			<td class="purchase_name text-left">
				<a href="{$lang_link}products/{$purchase->product->url}" data-product="{$purchase->product->id}">{$purchase->product_name|escape}</a>
				{if $purchase->variant->name}<br /><i class="text-md">{$purchase->variant->name|escape}</i>{/if}
                {if $order->paid && $purchase->variant->attachment}
                    <br />
					<a class="btn btn-info mt-sm" href="{$lang_link}order/{$order->url}/{$purchase->variant->attachment}">
						Сохранить
						<svg class="isvg" width="22" height="17" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg">
							<path fill="currentColor" d="M36 16l-8-8h-28v52h64v-44h-28zM32 54l-14-14h10v-16h8v16h10l-14 14z"></path>
						</svg>
					</a>
                {/if}
			</td>

			{* Price per unit *}
			<td class="purchase_price">
				<span class="text-nowrap">{($purchase->variant->price)|convert} {$currency->sign|escape}</span>
			</td>

			{* Quantity *}
			<td class="pr-2">x{$purchase->amount|escape} {$settings->units}</td>

			{* Extended price *}
			<td class="purchase_sum">
				<span class="text-nowrap text-bold">{($purchase->price*$purchase->amount)|convert} {$currency->sign|escape}</span>
			</td>
		</tr>
	{/foreach}

	{* Discount *}
	{if $order->discount > 0}
		<tr>
			<td></td>
			<td colspan="3" class="text-bold" data-language="cart_discount">{*$lang->cart_discount*}Ваша скидка:</td>
			<td colspan="1" class="purchase_total">{$order->discount}%</td>
		</tr>
	{/if}

	{* Coupon *}
	{if $order->coupon_discount > 0}
		<tr>
			<td></td>
			<td colspan="3" class="text-bold text-left" data-language="cart_coupon">{$lang->cart_coupon}</td>
			<td class="purchase_total">{$order->coupon_discount|convert} {$currency->sign|escape}</td>
		</tr>
	{/if}

	{* Delivery *}
	{if !$order->separate_delivery && $order->delivery_price > 0}
		<tr>
			<td></td>
			<td colspan="3" class="text-left">{$delivery->name|escape}{$order->separate_delivery}</td>
			<td>{if $order->delivery_price>0}{$order->delivery_price|convert} {$currency->sign|escape}{else}бесплатно{/if}</td>
		</tr>
	{/if}

	{* Delivery price *}
	{if $order->separate_delivery}
		<tr>
			<td></td>
			<td colspan="3" class="text-left">
				<span data-language="order_delivery">{$lang->order_delivery}</span>
			</td>
			<td>{$order->delivery_price|convert} {$currency->sign|escape}</td>
		</tr>
	{/if}

	{* Total *}
	<tfoot>
		<tr class="purchase_total">
			<td></td>
			<td colspan="3" data-language="cart_total_price">{$lang->cart_total_price}:</td>
			<td class="total_sum text-nowrap">
				{$order->total_price|convert} {$currency->sign|escape}
			</td>
		</tr>
	</tfoot>
</table>
{/if}

<div class="row">
	<div class="col-lg-6 mb-2">
		<div class="form">
			<div class="h3 text-caps mb-1" data-language="order_details">
				{*$lang->order_details*}
				<span>Информация</span> о заказе
			</div>
			{* Order details *}
			<div class="block">
				<table class="order_details">
					<tr>
						<td>
							<span data-language="user_order_status">{$lang->user_order_status}</span>
						</td>
						<td>
							{$order_status->name|escape}
							{if $order->paid == 1}
								, <span data-language="status_paid">{$lang->status_paid}</span>
							{/if}
						</td>
					</tr>
					<tr>
						<td>
							<span data-language="order_date">{$lang->order_date}</span>
						</td>
						<td>{$order->date|date} <span data-language="order_time">{$lang->order_time}</span> {$order->date|time}</td>
					</tr>
					<tr>
						<td>
							<span data-language="order_name">{$lang->order_name}</span>
						</td>
						<td>{$order->name|escape}</td>
					</tr>
					<tr>
						<td>
							<span data-language="order_email">{$lang->order_email}</span>
						</td>
						<td>{$order->email|escape}</td>
					</tr>
					{if $order->phone}
						<tr>
							<td>
								<span data-language="order_phone">{$lang->order_phone}</span>
							</td>
							<td>{$order->phone|escape}</td>
						</tr>
					{/if}
					{if $order->address}
						<tr>
							<td>
								<span data-language="order_address">{$lang->order_address}</span>
							</td>
							<td>{$order->address|escape}</td>
						</tr>
					{/if}
					{if $order->comment}
						<tr>
							<td>
								<span data-language="order_comment">{$lang->order_comment}</span>
							</td>
							<td>{$order->comment|escape|nl2br}</td>
						</tr>
					{/if}
				</table>
			</div>
		</div>
	</div>

	<div class="col-lg-6 mb-2">
		<div class="form">
		{if !$order->paid}

			{* Payments *}
			{if $payment_methods && !$payment_method && $order->total_price>0}
				<form class="delivery" method="post">
					<div class="h3 text-caps mb-1" data-language="order_payment_details">						{*$lang->order_payment_details*}
						<span>Выберите удобный</span> способ оплаты
					</div>
					{foreach $payment_methods as $payment_method}
						<div class="delivery_item clearfix">
							<label class="delivery_label{if $payment_method@first} active{/if}">
								<input class="input_delivery" onclick="payment_click({$payment_method->id})"  type="radio" name="payment_method_id" value="{$payment_method->id}" {if $delivery@first && $payment_method@first} checked{/if} id="payment_{$delivery->id}_{$payment_method->id}">

								<span class="delivery_name">
									{if $payment_method->image}
										<img src="{$payment_method->image|resize:50:50:false:$config->resized_payments_dir}"/>
									{/if}
									{$total_price_with_delivery = $cart->total_price}
									{if !$delivery->separate_payment && $cart->total_price < $delivery->free_from}
										{$total_price_with_delivery = $cart->total_price + $delivery->price}
									{/if}

									{$payment_method->name|escape} {$lang->cart_deliveries_to_pay} <span class="text-nowrap">{$order->total_price|convert:$payment_method->currency_id} {$all_currencies[$payment_method->currency_id]->sign}</span>
								</span>
							</label>
							<div class="delivery_description p_{$payment_method->id}">
								{$payment_method->description}
							</div>
						</div>
					{/foreach}

					<input class="button mt-1" type="submit" data-language="cart_checkout" value="{*$lang->cart_checkout*}Выбрать" name="checkout">
				</form>

			{elseif $payment_method}
				{* Selected payment *}
				<div class="">
					<div class="method">
						<span data-language="order_payment">{*$lang->order_payment*}Выбран способ оплаты:</span>
						<span class="text-bold method_name">"{$payment_method->name|escape}"</span>
						{*if $payment_method->description}
							<div class="method_description text-md my-sm">
								{$payment_method->description}
							</div>
						{/if*}

						{* Payment form is generated by payment module *}
						<div class="mt-sm">{checkout_form order_id=$order->id module=$payment_method->module}</div>

						<form class="method_form mt-2 mb-1" method="post">
							<input class="btn btn-light" type=submit name='reset_payment_method' data-language="order_change_payment" value='{$lang->order_change_payment}'/>
						</form>
					</div>
				</div>
			{/if}
		{/if}
		</div>
	</div>
</div>
