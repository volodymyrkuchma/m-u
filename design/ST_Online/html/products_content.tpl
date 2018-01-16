{if $products}
	{foreach $products as $product}
		<div class="col-sm-6 col-md-6 col-lg-4 col-xl-3 products-item">
			{include file="product_list.tpl"}
		</div>
	{/foreach}
{else}
	<div style='margin:5vh 2vw 20vh'>
		<div class="h3 my-sm">Предложения не найдены.</div>
		Попробуйте зайти позже или измените запрос.
	</div>
{/if}