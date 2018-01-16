{* The brand page template *}

{* The canonical address of the page *}
{$canonical="/brands" scope=parent}

{* The page heading *}
<h1 class="page_header">{$page->name}</h1>

{* Список брендов *}
{if $brands}
<div class="row brands_list-page clearfix mb-2">
	{foreach $brands as $b}
	{if $b->visible}
		<div class="item col-sm-6 col-md-4 col-lg-3 col-xl-20">
			<a class="link anim-all" href="{$lang_link}brands/{$b->url}">

				{* Изображение *}
				{if $b->image}
				<div class="image"><img src="{$b->image|resize:150:150:false:$config->resized_brands_dir}" alt="{$b->name|escape}" title="{$b->name|escape}"></div>
				{/if}

				{* Название *}
				<div class="name text-bold{if $b->image} mt-sm{/if}" data-brand="{$b->id}">
					{$b->name}
				</div>

				{* Краткое описание *}
				{if $b->annotation}
					<div class="annotation mt-sm">{$b->annotation|strip_tags|truncate:111:'...'}</div>
				{else}{/if}
			</a>
		</div>
	{/if}
	{/foreach}
</div>
{/if}

{* Тело страницы *}
{if $page->description}
	<hr class="my-2">
	<article class="text-light text-md px-1 readmore_js">
		<h2 class="mb-1 text-bold"><span>{$smarty.server.SERVER_NAME}</span> - производители и торговые марки</h2>
		{$page->description}
	<article>
	<br />
{/if}