{* Filters *}
{if ($category->brands || $prices || $features)  && $products|count > 0}

	<div class="filters_heading fn_switch btn btn-light btn-lg hidden-lg-up my-1">
		<span data-language="filters">{*$lang->filters*}Фильтры</span>
		<svg class="isvg" width="22" height="32">{include file='svg.tpl' item='isvg-arrow_d'}</svg>
	</div>

	<div class="filters">
		{* Ajax Price filter *}
		{if $prices && $products|count > 0}

			<div class="filter_group price">
				<div class="filter_name" data-language="features_price">
				{$lang->features_price}, {$currency->sign|escape}
				</div>

				{* Price slider *}
				<div id="fn_slider_price"></div>

				{* Price range *}
				<div class="price_range">
					<input class="min_input" id="fn_slider_min" name="p[min]" value="{($prices->current->min|default:$prices->range->min)|escape}" data-price="{$prices->range->min}" type="text">
					<input class="max_input" id="fn_slider_max" name="p[max]" value="{($prices->current->max|default:$prices->range->max)|escape}" data-price="{$prices->range->max}" type="text">
				</div>
			</div>
		{/if}

		{* Brand filter *}
		{if $category->brands}
		    <div class="filter_group">
				{* Brand name *}
				<div class="filter_name" data-language="features_manufacturer">
					{$lang->features_manufacturer}
				</div>

				<div class="row">
					{* Display all brands *}
					<div class="item col-6 col-md-4 col-lg-12">
						<a class="filter_link{if !$brand->id && !$smarty.get.b} checked{/if}" href="{furl params=[brand=>null, page=>null]}">
							<i class="indicator"></i>
							<span data-language="features_all">{$lang->features_all}</span>
						</a>
					</div>

					{* Brand list *}
					{foreach $category->brands as $b}
					{if $b->visible}
						<div class="item col-6 col-md-4 col-lg-12{if $b@iteration>5 && !$smarty.get.b} hidden{/if}">
							<a class="filter_link{if $brand->id == $b->id || $smarty.get.b && in_array($b->id,$smarty.get.b)} checked{/if}" href="{furl params=[brand=>$b->url, page=>null]}">
								<i class="indicator"></i>
								<span>{$b->name|escape}</span>
							</a>
						</div>
						{if $b@last && $b@iteration >5 && !$smarty.get.b}
						<a href="javascript:void(0)" class="color link-more" onclick="$(this).parent().find('.hidden').removeClass('hidden'); $(this).hide();" >Показать ещё</a>
						{/if}
					{/if}
					{/foreach}
				</div>

		    </div>
		{/if}

		{* Features filter *}
		{if $features}
		    {foreach $features as $key=>$f}
			    {* Feature name *}

				<div class="filter_group">
					<div class="filter_name" data-feature="{$f->id}">{$f->name}</div>

					<div class="row">
						{* Display all features *}
						<div class="item col-6 col-md-4 col-lg-12{if !$smarty.get.$key} checked{/if}">
							<a class="filter_link" href="{furl params=[$f->url=>null, page=>null]}">
								<i class="indicator"></i>
								<span data-language="features_all">{$lang->features_all}</span>
							</a>
						</div>

						{* Feture value *}
						{foreach $f->options as $o}
							<div class="item col-6 col-md-4 col-lg-12{if $o@iteration>5 && !$smarty.get.$key} hidden{/if}">
								<a class="filter_link{if $smarty.get.{$f@key} && in_array($o->translit,$smarty.get.{$f@key})} checked{/if}" href="{furl params=[$f->url=>$o->translit, page=>null]}">
									<i class="indicator"></i>
									<span>{$o->value|escape}</span>
								</a>
							</div>
							{if $o@last && $o@iteration >5 && !$smarty.get.$key}
							<a href="javascript:void(0)" class="color link-more" onclick="$(this).parent().find('.hidden').removeClass('hidden'); $(this).hide();" >Показать ещё</a>
							{/if}
						{/foreach}
					</div>
				</div>
		    {/foreach}
		{/if}
	</div>
{/if}