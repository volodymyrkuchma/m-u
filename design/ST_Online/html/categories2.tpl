{$lev_MAX = 3 scope=parent}				{* До какого уровня выводить дерево категорий в выпадающем меню категорий *}
{$sub_MAX = 5 scope=parent}				{* Сколько МАКСИМУМ показывать подкатегорий в списке ВТОРОГО уровня в выпадающем меню категорий *}



{* Категории товаров ГОРИЗОНТАЛЬНОЕ МЕНЮ *}
<nav class="drop_block" id=header_cat>
	{function name=header_cat}
	{if $categories && $level <= $lev_MAX}
		<ul class="{if $level==1}links {/if}lev{$level}">

			{assign var="sub_count" value=1}
			{foreach $categories as $c}
				{if $c->visible && $c->subcategories}

					{* Проверка через шаблон, есть ЛИ ВИДИМЫЕ подразделы С АКТИВНЫМИ товарами. *}
					{*assign var="countPr" value=0}
					{if $c->subcategories}
						{foreach $c->subcategories as $c1}{if $c1->visible && $c1->products_count>0}{$countPr = $countPr + 1}{/if}{/foreach}
					{/if*}



					<li class="{if $sub_count > $sub_MAX && $level >= 2}hidden {/if}sub{if in_array($category->id, $c->children)} selected{/if}">
						<a href="catalog/{$c->url}">
							{$c->name|truncate:30:'...'|escape}
							{if $c->products_count}<span>({$c->products_count})</span>{/if}
							{if strtotime($c->created) >= strtotime('-1 months')}<label title='Добавлен в каталог недавно'>NEW</label>{/if}
						</a>

						{if $lev_MAX > $level}
							<div class="drop_btn sub-switcher">&#x25BC;</div>

							{* условие, ЕСЛИ нужно скрывать ПУСТЫЕ категории автоматически / не отвлекать посетителя на пустые разделы *}
							{*if $countPr>0*}
							{header_cat categories=$c->subcategories level=$level + 1 parent_id=$c->id}
							{*/if*}
						{/if}
					</li>
				{elseif $c->visible}
					<li class="{if $sub_count > $sub_MAX && $level >= 2}hidden {/if}{if in_array($category->id, $c->children)}selected{/if}">
						<a href="catalog/{$c->url}">
							{$c->name|truncate:30:'...'|escape}
							{if $c->products_count}<span>({$c->products_count})</span>{/if}
							{if strtotime($c->created) >= strtotime('-1 months')}<label title='Добавлен в каталог недавно'>NEW</label>{/if}
						</a>
					</li>
				{/if}

			{$sub_count = $sub_count + 1}
			{/foreach}
		</ul>
	{/if}
	{/function}
	{header_cat categories=$categories level=1}
</nav>