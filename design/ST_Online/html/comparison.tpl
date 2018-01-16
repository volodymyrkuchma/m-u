{* The products comparison page *}

{* The page title *}
{$meta_title = $lang->comparison_title scope=parent}

{* The page heading *}
<h1 class="page_header" data-language="comparison_header">
	{$lang->comparison_header}
</h1>

{if $comparison->products}
    <div class="comparison_page">
        <div class="comparison_left">

			<div class="fn_product fn_resize compare_controls">
                {* Show all/different product features *}
                {if $comparison->products|count > 1}
                    <div class="fn_show compare_show">
                        <a href="show_all" class="active"><span data-language="comparison_all">{$lang->comparison_all}</span></a>
                        <a href="show_dif" class="unique"><span data-language="comparison_unique">{$lang->comparison_unique}</span></a>
                    </div>
                {/if}
            </div>

            {* Feature name *}
            {if $comparison->features}
                {foreach $comparison->features as $id=>$cf}
                    <div class="cprs_feature_{$id} cell{if $cf->not_unique} not_unique{/if}" data-use="cprs_feature_{$id}">
                        <span data-feature="{$cf->id}">{$cf->name}</span>
                    </div>
                {/foreach}
            {/if}
        </div>
        <div class="fn_comparison_products comparison_products products-grid">
            {foreach $comparison->products as $id=>$product}
                <div class="products-item p-0">
                    <div class="fn_resize">
                        {include file="product_list.tpl"}
                    </div>

                    {* Feature value *}
                    {if $product->features}
                        {foreach $product->features as $id=>$value}
                            <div class="cprs_feature_{$id} cell{if $comparison->features.{$id}->not_unique} not_unique{/if}">
                                {$value|default:"&mdash;"}
                            </div>
                        {/foreach}
                    {/if}

                </div>
            {/foreach}
        </div>
    </div>
{else}
    <div class="my-1 h3">
        <span data-language="comparison_empty">{$lang->comparison_empty}</span>
    </div>
{/if}
