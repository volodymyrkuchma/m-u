{include file='!config.tpl'}
{* The Categories page *}

{* The canonical address of the page *}
{if $set_canonical}
	{if $category}
		{$canonical="/catalog/{$category->url}" scope=parent}
	{elseif $brand}
		{$canonical="/brands/{$brand->url}" scope=parent}
    {elseif $page->url=='discounted'}
        {$canonical="/discounted" scope=parent}
    {elseif $page->url=='bestsellers'}
        {$canonical="/bestsellers" scope=parent}
	{elseif $keyword}
		{$canonical="/all-products" scope=parent}
	{else}
		{$canonical="/all-products" scope=parent}
	{/if}
{/if}


{* The page heading *}
{if $keyword}
	<h1 class="page_header mb-1" data-language="products_search">
		{$lang->products_search} {$keyword|escape}
	</h1>
{elseif $page}
	<h1 class="page_header mb-1" data-page="{$page->id}">
		{$page->name|escape}
	</h1>
{else}
	<h1 class="page_header mb-1" data-category="{$category->id}">
		{if $category->name_h1|escape}{$category->name_h1|escape}{else}{$category->name|escape}{/if} {$brand->name|escape} {$filter_meta->h1|escape}
	</h1>
{/if}


{* ПОДКАТЕГОРИИ Открытого раздела каталога *}
{$url="/catalog/{$category->url}" scope=parent}

{if $category->subcategories|count>2}	{$cats=$category->subcategories}
{*elseif $category->parent_id==0}		{$cats=$categories*}
{elseif !$products}						{$cats=$category->path[($category->path)|count-2]->subcategories}{/if}

{*if $cats && !$smarty.get.b && $url == $smarty.server.REQUEST_URI*}
{if $cats && !$smarty.get.b}
	<div class="pb-1" id=subcats>
		<div class="h4 mb-sm">
			Вы можете <span>уточнить направление</span>
		</div>

		<div class="row subcats-list fn_subcats">
			{foreach $cats as $c}
			{if $c->visible && $c->url != $category->url}
			<div class="col anim-all">
				<div class="item">
					<div class="image">
						{if $c->image}	<img src="{$c->image|resize:140:110:false:$config->resized_categories_dir}" alt="{if $c->image}{$c->name|escape}{/if}"/>
						{else}			<svg class="isvg" width="33" height="33">{include file='svg.tpl' item='isvg-noimage'}</svg>{/if}
					</div>
					<div class="h4 name">{$c->name|escape|truncate:40:'...'}{if $c->products_count}<span>({$c->products_count}){/if}</span></div>
					<a class="over-all" href="catalog/{$c->url}" data-category="{$c->id}"></a>
				</div>
			</div>
			{/if}
			{/foreach}
		</div>
	</div>
{/if}


{* Sidebar with filters *}
<div class="sidebar sidebar_top">
	{include file='features.tpl'}
</div>

<div class="products_container">
	{if $current_page_num == 1 && ($brand && $brand->annotation)}
		<article class="mb-1">
			{$brand->annotation}
		</article>
	{/if}

	{if $current_page_num == 1 && !$smarty.get.b && ($category->annotation)}
		<article class="readmore_js mb-1">
			{if !$smarty.get.b}
				{* Краткое описание категории *}
				{$category->annotation}

				{if $category->description}
					<a class='text-sm text-underline my-1' href='#category_description'>Читать больше</a>
				{/if}
			{/if}
		</article>
	{/if}



	{if $products}
		{* Product Sorting /  URLs Pagination *}
		<div class="row products-toolbar mb-1">
			<div class="col-md-7 col-lg-8 fn_products_sort">{include file="products_sort.tpl"}</div>
			<div class="col-md-5 col-lg-4 fn_pagination">{include file='chpu_pagination.tpl'}</div>
		</div>

		{* Product list *}
		<div id="fn_products_content" class="row fn_categories {$smarty.get.module} products-grid">
			{include file="products_content.tpl"}
		</div>

		{* Product Sorting /  URLs Pagination *}
		{if $products|@count >8}
		<div class="row products-toolbar last_child">
			<div class="col-md-7 col-lg-8 fn_products_sort">{include file="products_sort.tpl"}</div>
			<div class="col-md-5 col-lg-4 fn_pagination">{include file='chpu_pagination.tpl'}</div>
		</div>
		{/if}
	{else}
		<div style='margin:5vh 0 20vh'>
			<div class="h3 my-sm">Варианты не найдены.</div>
			{if $category->name}Раздел "{$category->name}" может{else}Предложения могут{/if} быть на стадии редактирования или наполнения.<br />
			Попробуйте зайти позже или <a class='' href='#search'>воспользуйтесь поиском</a>.
		</div>
	{/if}



	{if $page->body}
		<article class="my-1 text-light text-md">
			{$page->body}
		</article>
	{/if}

	{if $current_page_num == 1 && (!$category || !$brand) && ($category->description || $brand->description)}
		{if $total_pages_num == 1}<hr class="my-sm">{/if}
		<article class="mt-2 text-light text-md readmore_js" id="category_description">
			{if $page}	<h2 data-page="{$page->id}">{$page->name|escape}</h2>
			{else}		<h2 data-category="{$category->id}">{$category->name|escape} {$brand->name}</h2>
			{/if}

			{* Описание категории *}
			{$category->description}

			{* Описание бренда *}
			{$brand->description}
		</article>
	{/if}

</div>

{* Sidebar with browsed products *}
<div class="sidebar sidebar_bottom">


	{* ПРОСМОТРЕННЫЕ / Боковая часть *}
	{get_browsed_products var=browsed_products limit=6}
	{if $browsed_products}
		<div class="h3 title">
			{$browsed_products|@count|plural:'<span>Последний</span> открытый':'<span>Последние</span> открытые':'<span>Последние</span> открытые'}
		</div>
		<div class="browsed-list">
			{foreach $browsed_products as $browsed_product}
			<div class="item">
				<a class="image" href="{$lang_link}products/{$browsed_product->url}">
					{if $browsed_product->image->filename}
						<img src="{$browsed_product->image->filename|resize:50:50}" alt="{$browsed_product->name|escape}" title="{$browsed_product->name|escape}">
					{else}
						<svg class="isvg" width="24" height="24">{include file='svg.tpl' item='isvg-noimage'}</svg>
					{/if}
				</a>
			</div>
			{/foreach}
		</div>
		<hr class="mb-2">
	{/if}



	{* Пример рекламного блока *}
	<div class="mb-2 hidden-md-down">
		<a class="image-b" href="" target=blank><img src="design/{$settings->theme}/images/banners/aside_240x400.jpg" alt="" /></a>
	</div>



	<div class="mb-2">
		<div class="h3 title">Информация</div>
		<div class="my-1 px-1 bdot-l bdot-r text-md">
			<div class="text-bold color text-caps">Режим работы магазина:</div>
			{if $time_work1}
				{$time_work1}<br />
				{if $time_work2}{$time_work2}<br />{/if}
				<br />
			{/if}
			Приём заказов онлайн, круглосуточно!
		</div>
		<div class="my-1 px-1 bdot-l bdot-r text-md">
			При заказе с 7:00 до 10:00, возможна доставка по городу в день заказа!
		</div>
		<div class="my-1 px-1 bdot-l bdot-r text-md">
			Доступен предварительный заказ предложений для товаров с остатком ноль
		</div>
	</div>






	{*
		Виджет контакта. Свой код можно получить здесь / после авторизации в сервисе /
		http://vk.com/dev/Community?height=400&link=http%3A%2F%2Fvk.com%2Fpublic20003922&mode=3&oid=-20003922&wide=&width=auto

	<script type="text/javascript" src="//vk.com/js/api/openapi.js?127"></script>
	<!-- VK Widget -->
	<div id="vk_groups" class="my-2"></div>
	{literal}
	<script type="text/javascript">
	VK.Widgets.Group("vk_groups", {redesign: 1, mode: 3, width: "auto", height: "320", color1: 'FFFFFF', color2: '000000', color3: '3C3C42'}, 20003922);
	</script>
	{/literal}
	*}
</div>