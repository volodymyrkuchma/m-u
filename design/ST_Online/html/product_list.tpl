{* Product preview *}
<div class="preview fn_product product">
<div class="fn_transfer">

	{* Изображение товара в блоке *}
	<a class="image preview_image{if $smarty.get.module=='ComparisonView'} fn_zoom{/if}" href="{if $smarty.get.module=='ComparisonView'}{$product->image->filename|resize:800:600:w}{else}{$lang_link}products/{$product->url}{/if}" {if $smarty.get.module=='ComparisonView'}data-fancybox="group" data-caption="{$product->name|escape}"{/if}>
		{if $product->image->filename}	<img class="fn_img" src="{$product->image->filename|resize:170:170}" alt="{$product->name|escape}" title="{$product->name|escape}" />
		{else}							<svg class="fn_img isvg" width="44" height="44">{include file='svg.tpl' item='isvg-noimage'}</svg>{/if}
		{if $product->special}			<img class="promo_img" src='files/special/{$product->special}' alt='{$product->special}' title="{$product->special}"/>{/if}
	</a>



	{* Рейтинг товара в блоке *}
	<div id="product_{$product->id}" class="disabled product_rating"{if $product->rating > 0} itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating"{/if}>

		<span class="rating_starOff">
		<span class="rating_starOn" style="width:{$product->rating*90/5|string_format:'%.0f'}px;"></span>
		</span>
		<span class="rating_text{if $product->rating==0} hidden{/if}">({$product->rating|string_format:"%.1f"})</span>

		{*Вывод количества голосов данного товара, скрыт ради микроразметки*}
		{if $product->rating > 0}
		<span class="hidden" itemprop="reviewCount">{$product->votes|string_format:"%.0f"}</span>
		<span class="hidden" itemprop="ratingValue">({$product->rating|string_format:"%.1f"})</span>
		{*Вывод лучшей оценки товара для микроразметки*}
		<span class="hidden" itemprop="bestRating" style="display:none;">5</span>
		{else}
		<span class="hidden">({$product->rating|string_format:"%.1f"})</span>
		{/if}
	</div>


	{* Название товара в блоке *}
	<a class="product_name" data-product="{$product->id}" href="{$lang_link}products/{$product->url}">{$product->name|truncate:110:'...'}</a>


	{* Цена *}
	<div class="price_container">
		{* Старая цена *}
		<div class="old_price{if !$product->variant->compare_price} hidden{/if}">
			<span class="fn_old_price">{$product->variant->compare_price|convert}</span> <span>{*$currency->sign|escape*}</span>
		</div>

		{* Основная цена *}
		<div class="price">
			<span class="fn_price">{$product->variant->price|convert}</span> <span>{$currency->sign|escape}</span>
		</div>
	</div>


	<form class="fn_variants preview_form" action="/{$lang_link}cart">

	   {* Предзаказ / Настройки сайта в панели управления *}
	   {if !$settings->is_preorder && $product->variant->stock == 0}
			{* Нет на складе *}
			<div class="mt-1 text-bold text-sm text-caps fn_not_preorder {if $product->variant->stock > 99990} hidden{/if}" data-language="out_of_stock">
				{$lang->out_of_stock}
			</div>
		{elseif $settings->is_preorder && $product->variant->stock == 0}
			{* Предзаказ *}
			<button class="btn btn-info buy fn_is_preorder{if $product->variant->stock > 0} hidden{/if}" type="submit" data-language="pre_order">{$lang->pre_order}</button>
		{/if}


		{* Кнопка "Купить" *}
		<button class="button buy fn_is_stock{if $product->variant->stock < 1} hidden{/if}{if $product->variant->price==0} disabled{/if}" type="submit" data-language="add_to_cart">
			Купить{*$lang->add_to_cart*}
			<svg class="isvg" width="20" height="20">{include file='svg.tpl' item='btn_in_cart'}</svg>
		</button>

		{* Варианты товара *}
		<select name="variant" class="fn_variant variant_select {if $product->variants|count == 1}hidden{/if}">
			{foreach $product->variants as $v}
				<option value="{$v->id}" data-price="{$v->price|convert}" data-stock="{$v->stock}"{if $v->compare_price > 0} data-cprice="{$v->compare_price|convert}"{/if}{if $v->sku} data-sku="{$v->sku}"{/if}>{if $v->name}{$v->name}{else}{$product->name|escape}{/if}</option>
			{/foreach}
		</select>
	</form>


	{* Кнопки сравнения/избранного *}
	<div class="overlay_buttons">
		{* Сравнение *}
		{if $smarty.get.module != "ComparisonView"}
			{if !in_array($product->id,$comparison->ids)}
				<a class="fn_comparison comparison_button" href="#" data-id="{$product->id}" title="{$lang->add_comparison}" data-result-text="{$lang->remove_comparison}">
				<svg class="isvg" width="20" height="20">{include file='svg.tpl' item='isvg-compare'}</svg>
				</a>
			{else}
				<a class="fn_comparison comparison_button selected" href="#" data-id="{$product->id}" title="{$lang->remove_comparison}" data-result-text="{$lang->add_comparison}">
				<svg class="isvg" width="20" height="20">{include file='svg.tpl' item='isvg-compare'}</svg>
				</a>
			{/if}
		{/if}

		{* Избранное *}
		{if $smarty.get.module != "WishlistView"}
			{if $product->id|in_array:$wished_products}
				<a href="#" data-id="{$product->id}" class="fn_wishlist wishlist_button selected" title="{$lang->remove_favorite}" data-result-text="{$lang->add_favorite}">
				<svg class="isvg" width="20" height="20">{include file='svg.tpl' item='isvg-wishlist'}</svg>
				</a>
			{else}
				<a href="#" data-id="{$product->id}" class="fn_wishlist wishlist_button" title="{$lang->add_favorite}" data-result-text="{$lang->remove_favorite}">
				<svg class="isvg" width="20" height="20">{include file='svg.tpl' item='isvg-wishlist'}</svg>
				</a>
			{/if}
		{/if}
	</div>


	{* наклейки автоматические "Рекомендуемый" / "Скидка" *}
	{if $smarty.get.module != "MainView"}
	<div class="product-labels">
		{if $product->featured}
		<div class='featured'>ХИТ ПРОДАЖ</div>
		{/if}

		{if $product->variant->compare_price && $product->variant->price >0}
			{*$skidka = {$product->variant->compare_price}-{$product->variant->price}*}
			{$skidka = {floor(100-{$product->variant->price}/($product->variant->compare_price)*100)}}
			{if $skidka >0}
			<div class="discounted">Экономия {$skidka|convert}%</div>
			{/if}
		{/if}
	</div>
	{/if}


	{* Удалить ИЗ избранного/сравнения. только для этих разделов вывод *}
	{if $smarty.get.module == "ComparisonView"}
		<a href="#" class="fn_comparison selected remove_link" data-id="{$product->id}">
			<svg class="isvg" width="14" height="14">{include file='svg.tpl' item=remove_link}</svg>
			<span>{$lang->remove_comparison}</span>
		</a>
	{/if}
	{if $smarty.get.module == "WishlistView"}
		<a href="#" class="fn_wishlist selected remove_link" data-id="{$product->id}">
			<svg class="isvg" width="14" height="14">{include file='svg.tpl' item=remove_link}</svg>
			<span>{$lang->remove_favorite}</span>
		</a>
	{/if}

</div>
</div>