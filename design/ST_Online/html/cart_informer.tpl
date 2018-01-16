{* Информер корзины / отдаётся аяксом *}
<a class="{if $cart->total_products > 0}active{else}disabled{/if}" href='/cart'>
	<svg class="isvg" width="44" height="30">{include file='svg.tpl' item='header_cart'}</svg>
	<div>
		<div class="title hidden-sm-down" data-language="index_cart">{$lang->index_cart}</div>
		<span class="text">
			{if $cart->total_products}{($cart->total_price)|convert} {$currency->sign|escape}
			{else}ждёт ваш заказ{/if}
		</span>
	</div>
	<span class="count">{if $cart->total_products > 0}{$cart->total_products}{else}0{/if}</span>
</a>