{* page title *}
{$meta_title = $lang->wishlist_title scope=parent}

{* Заголовок страницы *}
<h1 class="page_header" data-language="wishlist_header">
	{$lang->wishlist_header}
</h1>

<div class="m-y-1">
	Список покупок - это удобное дополнение, с помощью которого Вы можете отложить понравившиеся товары и позже легко их найти.
	Внимание, список покупок не является резервом заказа в Магазине!
</div>

{if $page->description}
	<div class="m-y-1">
		{$page->description}
	</div>
{/if}

<br />

{* Список избранных товаров *}
{if $wished_products|count}
	<div class="row {$smarty.get.module} products-grid fn_wishlist_page mt-2 mb-2">
		{foreach $wished_products as $product}
			<div class="col-sm-6 col-md-4 col-lg-3 col-xl-20 products-item">
				{include "product_list.tpl"}
			</div>
		{/foreach}
	</div>

{else}
	<div style='margin:5vh 0 20vh'>
		<span data-language="wishlist_empty">{$lang->wishlist_empty}</span>
	</div>
{/if}