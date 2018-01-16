{* Страница товара *}
{* переменные для шаблона *}
{include file='!config.tpl'}

{* Канонический адрес страницы *}
{$canonical="/products/{$product->url}" scope=parent}



{*=| Информация о товаре / Карточка |=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*}
<div class="fn_product product product-item" itemscope itemtype="http://schema.org/Product">

	{* The product name *}
	<h1 class="page_header" data-product="{$product->id}" itemprop="name">
		{$product->name|escape} {if $product->variants|count == 1 && !empty($product->variant->name)}({$product->variant->name|escape}){/if}
	</h1>

	<div class="row fn_transfer mx-0">
		<div class="col-md-6 col-lg-5 col-xl-5 mb-2 pl-0 pr-0 pr-sm-1">
			<div class="image product_image">
				{* Main product image *}
				{if $product->image}
					<a href="{$product->image->filename|resize:800:600:w}" data-fancybox="group" data-caption="{$product->name|escape}">
						<img class="fn_img product_img" itemprop="image" src="{$product->image->filename|resize:300:300}" alt="{$product->name|escape}" title="{$product->name|escape}">
					</a>

				{else}<svg class="fn_img isvg" width="44" height="44">{include file='svg.tpl' item='isvg-noimage'}</svg>{/if}

				{* Promo image *}
				{if $product->special}
					<img class="promo_img" alt='{$product->special}' title="{$product->special}"  src='files/special/{$product->special}'/>
				{/if}

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

			</div>

			{* images *}
			{if $product->images|count > 1}
				<div class="fn_images product_images">
					{foreach $product->images|cut as $i=>$image}
					<div class="item">
					<a class="image" href="{$image->filename|resize:800:600:w}" data-fancybox="group" data-caption="{$product->name|escape} #{$image@iteration}"><img src="{$image->filename|resize:80:80}" alt="{$product->name|escape}"/></a>
					</div>
					{/foreach}
				</div>
			{/if}
		</div>

		<div class="col-md-6 col-lg-7 col-xl-7 pr-0 pl-0 pl-sm-1 product_details" itemprop="offers" itemscope="" itemtype="http://schema.org/Offer">
			<div class="row">
				<div class="col-md-12 col-lg-5 col-xl-6 mb-2 text-md">
					{if $product->annotation && $product->description}
						<div class="mb-1">
							{$product->annotation|strip_tags|truncate:205:'...'}
							<a class='' href='#tabs'>Подробнее</a>
							<hr class="sm">
						</div>
					{/if}

					<div class="comp_wish_links mb-1">
						{* Wishlist *}
						{if $product->id|in_array:$wished_products}
							<a class="fn_wishlist selected product_wish" href="#" title="{$lang->product_remove_favorite}" data-result-text="{$lang->product_add_favorite}" data-language="product_remove_favorite" data-id="{$product->id}">
							<svg class="isvg" width="25" height="20">{include file='svg.tpl' item='isvg-wishlist'}</svg>
							</a>
						{else}
							<a class="fn_wishlist product_wish" href="#" title="{$lang->product_add_favorite}" data-result-text="{$lang->product_remove_favorite}" data-language="product_add_favorite" data-id="{$product->id}">
							<svg class="isvg" width="25" height="20">{include file='svg.tpl' item='isvg-wishlist'}</svg>
							</a>
						{/if}

						{* Сравнение *}
						{if !in_array($product->id,$comparison->ids)}
							<a class="fn_comparison product_compare" href="#" data-id="{$product->id}" title="{$lang->product_add_comparison}" data-result-text="{$lang->product_remove_comparison}" data-language="product_add_comparison">
							<svg class="isvg" width="25" height="20">{include file='svg.tpl' item='isvg-compare'}</svg>
							</a>
						{else}
							<a class="fn_comparison selected product_compare" href="#" data-id="{$product->id}" title="{$lang->product_remove_comparison}" data-result-text="{$lang->product_add_comparison}" data-language="product_remove_comparison">
							<svg class="isvg" width="25" height="20">{include file='svg.tpl' item='isvg-compare'}</svg>
							</a>
						{/if}
					</div>
					<hr class="sm">

					{*  SKU (stock keeping unit) number *}
					<div class="sku{if !$product->variant->sku} hidden{/if}">
						<span class="details_label" data-language="product_sku">{$lang->product_sku}:</span>
						<span class="fn_sku sku_nubmer">{$product->variant->sku|escape}</span>
					</div>

					{* Stock *}
					<div class="available y-middle clearfix">
						<span class="details_label">{$lang->available}:</span>
						<span class="no_stock fn_not_stock{if $product->variant->stock > 0} hidden{/if}">
							<svg class="isvg" width="15" height="13" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg">
								<path fill="currentColor" d="M32 53.375c11.75 0 21.375-9.625 21.375-21.375 0-4.75-1.75-9.375-4.625-13.125l-29.875 29.875c3.75 2.875 8.375 4.625 13.125 4.625zM10.625 32c0 4.75 1.75 9.375 4.625 13.125l29.875-29.875c-3.75-2.875-8.375-4.625-13.125-4.625-11.75 0-21.375 9.625-21.375 21.375zM32 5.375c14.625 0 26.625 12 26.625 26.625s-12 26.625-26.625 26.625-26.625-12-26.625-26.625 12-26.625 26.625-26.625z"></path>
							</svg>
							{$lang->product_out_of_stock}
						</span>
						<span class="in_stock fn_in_stock{if $product->variant->stock < 1} hidden{/if}">
							<svg class="isvg" width="15" height="13" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg">
								<path fill="currentColor" d="M57.996 17.062l-4.268-4.268c-0.788-0.786-2.060-0.786-2.846 0l-25.59 25.59-12.172-12.26c-0.786-0.786-2.058-0.786-2.846 0l-4.268 4.268c-0.786 0.788-0.786 2.060 0 2.846l17.848 17.968c0.786 0.786 2.060 0.786 2.846 0l31.296-31.298c0.786-0.784 0.786-2.060 0-2.846z"></path>
							</svg>
							{$lang->product_in_stock}
						</span>
					</div>

					{* Product Rating *}
					<div id="product_{$product->id}" class="product_rating"{if $product->rating > 0} itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating"{/if}>
						<span class="details_label" data-language="product_rating">{$lang->product_rating}:</span>
						<span class="rating_starOff">
							<span class="rating_starOn" style="width:{$product->rating*90/5|string_format:'%.0f'}px;"></span>
						</span>
						<span class="rating_text">({$product->rating|string_format:"%.1f"})</span>

							{*Вывод количества голосов данного товара, скрыт ради микроразметки*}
							{if $product->rating > 0}
								<span class="hidden" itemprop="reviewCount">{$product->votes|string_format:"%.0f"}</span>
								<span class="hidden" itemprop="ratingValue">({$product->rating|string_format:"%.1f"})</span>
								{*Вывод лучшей оценки товара для микроразметки*}
								<span class="hidden" itemprop="bestRating" style="display:none;">5</span>
							{else}<span class="hidden">({$product->rating|string_format:"%.1f"})</span>{/if}
					</div>
				</div>

				<div class="col-md-12 col-lg-7 col-xl-6 mb-1">
					<form class="fn_variants" action="/{$lang_link}cart">
						<div class="price_container">
							{* Price *}
							<div class="price">
								<span class="fn_price">{$product->variant->price|convert}</span> <span>{$currency->sign|escape}</span>
							</div>

							{* Old price *}
							<div class="old_price pl-1{if !$product->variant->compare_price} hidden{/if}">
								<span class="fn_old_price">{$product->variant->compare_price|convert}</span> <span>{*$currency->sign|escape*}</span>
							</div>
						</div>

						<div class="product_buttons mt-1">

							{* Product variants *}
							<select class="fn_variant variant_select mb-1{if $product->variants|count < 2} hidden{/if}" name="variant">
								{foreach $product->variants as $v}
									<option value="{$v->id}" data-price="{$v->price|convert}" data-stock="{$v->stock}"{if $v->compare_price > 0} data-cprice="{$v->compare_price|convert}"{/if}{if $v->sku} data-sku="{$v->sku}"{/if}>{if $v->name}{$v->name}{else}{$product->name|escape}{/if}</option>
								{/foreach}
							</select>

							<div class="y-middle">
								<div class="fn_is_stock{if $product->variant->stock < 1} hidden{/if}">
									{* Quantity *}
									<div class="amount fn_product_amount">
										<span class="minus">&minus;</span>
										<input class="input_amount" type="text" name="amount" value="1" data-max="{$product->variant->stock}">
										<span class="plus">&plus;</span>
									</div>
								</div>

								{if !$settings->is_preorder}
									{* Out of stock *}
									<div class="fn_not_preorder {if $product->variant->stock > 0} hidden{/if} text-sm text-bold text-light text-caps" data-language="out_of_stock">{$lang->out_of_stock}</div>
								{else}
									{* Preorder *}
									<div class="fn_is_preorder {if $product->variant->stock > 0} hidden{/if}">
										<button class="btn btn-info py-sm product_btn" type="submit" data-language="product_pre_order">{$lang->product_pre_order}</button>
									</div>
								{/if}

								{* Submit button *}
								<button class="fn_is_stock button product_btn{if $product->variant->stock < 1} hidden{/if}" type="submit" data-language="product_add_cart">
									{$lang->product_add_cart}
									<svg class="isvg" width="22" height="22">{include file='svg.tpl' item='btn_in_cart'}</svg>
								</button>
							</div>
						</div>
					</form>
				</div>

				{* Share buttons *}
				<div class="col-12 my-1 p-1 b bg-light z_day">
					<p class="text-bold text-md">Понравилось? Поделитесь с друзьями!</p>
					<div class="ya-share2" data-services="vkontakte,facebook,twitter,viber"></div>
				</div>
			</div>
		</div>
	</div>


	{* Previous/Next product *}
	{if $prev_product || $next_product}
	<nav class="pager clearfix">
		{if $prev_product}
			<a class="link-prev" href="{$lang_link}products/{$prev_product->url}">
				<svg class="isvg" width="26" height="26">{include file='svg.tpl' item='pager'}</svg>
				<span>{$prev_product->name|escape|truncate:80:'...'}</span>
			</a>
		{/if}

		{if $next_product}
			<a class="link-next" href="{$lang_link}products/{$next_product->url}">
				<span>{$next_product->name|escape|truncate:80:'...'}</span>
				<svg class="isvg" width="26" height="26">{include file='svg.tpl' item='pager'}</svg>
			</a>
		{/if}
	</nav>
	{/if}


	<div class="tabs clearfix" id=tabs>
		<div class="tab_navigation">
			{if $product->description}
				<a href="#description" data-language="product_description">{$lang->product_description}</a>
			{/if}

			{if $product->features}
				<a href="#features" data-language="product_features">{$lang->product_features}</a>
			{/if}

			<a href="#comments" data-language="product_comments">{$lang->product_comments}</a>

			{* Дополнительные вкладки с информацией / ссылки *}
			{if $device != mobile}
				{* Наши гарантии *}
				<a href="#garanty" data-language="product_garanty">{*$lang->product_garanty*}Наши гарантии</a>

				{* Как получить заказ *}
				<a href="#my_order" data-language="product_my_order">{*$lang->product_my_order*}Как получить заказ</a>
			{/if}
		</div>

		<div class="tab_container">
			{if $product->description}
				<div id="description" class="tab product_description" itemprop="description">
					{$product->description}
				</div>
			{/if}

			{if $product->features}
				<div id="features" class="tab">
					<ul class="features">
						{foreach $product->features as $f}
							<li>
								<span class="features_name"><span>{$f->name}</span></span>
								<span class="features_value">{$f->value}</span>
							</li>
						{/foreach}
					</ul>
				</div>
			{/if}

			{* Comments *}
			<div id="comments" class="tab">
				<div class="row">
					<div class="col-lg-7 mb-1">
						{if $comments}
							{function name=comments_tree level=0}
								{foreach $comments as $comment}

									{* Comment anchor *}
									<a name="comment_{$comment->id}"></a>

									{* Comment list *}
									<div class="comment_item{if $level > 0} admin_note{/if}">

										<div class="comment_header">
											{* Comment name *}
											<span class="comment_author">{$comment->name|escape},</span>

											{* Comment date *}
											<span class="comment_date">{$comment->date|date}, {$comment->date|time}</span>

											{* Comment status *}
											{if !$comment->approved}
												<span class="status" data-language="post_comment_status">({$lang->post_comment_status})</span>
											{/if}
										</div>

										{* Comment content *}
										<div class="comment_content">
											{$comment->text|escape|nl2br}
										</div>

										{if isset($children[$comment->id])}
											{comments_tree comments=$children[$comment->id] level=$level+1}
										{/if}
									</div>
								{/foreach}
							{/function}
							{comments_tree comments=$comments}
						{else}
							<div class="no_comments my-1" data-language="product_no_comments">
								{*$lang->product_no_comments*}
								Удивительно, но никто не оставил ни одного отзыва.<br />
								Вы можете стать первым!
							</div>
						{/if}
					</div>

					<div class="col-lg-5 mb-2">
						{* Comment form *}
						<form class="comment_form fn_validate_product form" method="post">

							<div class="h3 text-light text-caps mb-1" data-language="product_write_comment">
								{$lang->product_write_comment}
							</div>

							{* Form error messages *}
							{if $error}
								<div class="message_error">
									{if $error=='captcha'}
										<span data-language="form_error_captcha">{$lang->form_error_captcha}</span>
									{elseif $error=='empty_name'}
										<span data-language="form_enter_name">{$lang->form_enter_name}</span>
									{elseif $error=='empty_comment'}
										<span data-language="form_enter_comment">{$lang->form_enter_comment}</span>
									{elseif $error=='empty_email'}
										<span data-language="form_enter_email">{$lang->form_enter_email}</span>
									{/if}
								</div>
							{/if}

							<div class="row">
								{* User's name *}
								<div class="col-lg-6 form_group">
									<input class="form_input" type="text" name="name" value="{$comment_name|escape}" placeholder="{$lang->form_name}*"/>
								</div>

								{* User's email *}
								<div class="col-lg-6 form_group">
									<input class="form_input" type="text" name="email" value="{$comment_email|escape}" data-language="form_email" placeholder="{$lang->form_email}"/>
								</div>
							</div>

							{* User's comment *}
							<div class="form_group">
								<textarea class="form_textarea" rows="3" name="text" placeholder="{$lang->form_enter_comment}*">{$comment_text}</textarea>
							</div>

							{* Captcha *}
							{if $settings->captcha_product}
								{get_captcha var="captcha_product"}
								<div class="captcha">
									<input class="form_input input_captcha" type="text" name="captcha_code" value="" placeholder="{*$lang->form_enter_captcha*}Код*"/>
									<div class="secret_number">{$captcha_product[0]|escape} + ? =  {$captcha_product[1]|escape}</div>
								</div>
							{/if}

							{* Submit button *}
							<input class="btn btn-light" type="submit" name="comment" data-language="form_send" value="{$lang->form_send}"/>
						</form>
					</div>
				</div>
			</div>

			{* Дополнительные вкладки с информацией / наполнение вкладок *}
			{if $device != mobile}
				{* Наши гарантии *}
				<div id="garanty" class="tab product_garanty">
					<div class="h3">Гарантии нашего магазина</div>
					<p>
						Lorem Ipsum - это текст-"рыба", часто используемый в печати и вэб-дизайне. Lorem Ipsum является стандартной "рыбой" для текстов на латинице с начала XVI века. В то время некий безымянный печатник создал большую коллекцию размеров и форм шрифтов, используя Lorem Ipsum для распечатки образцов. Lorem Ipsum не только успешно пережил без заметных изменений пять веков, но и перешагнул в электронный дизайн.
					</p>
					<div class="h4 mt-1">Информация и описание</div>
					<p>
						Его популяризации в новое время послужили публикация листов Letraset с образцами Lorem Ipsum в 60-х годах и, в более недавнее время,
						программы электронной вёрстки типа Aldus PageMaker, в шаблонах которых используется Lorem Ipsum.
					</p>
				</div>


				{* Как получить заказ *}
				<div id="my_order" class="tab product_garanty">
					<div class="h3">Как получить заказ</div>
					<p>
						Lorem Ipsum - это текст-"рыба", часто используемый в печати и вэб-дизайне. Lorem Ipsum является стандартной "рыбой" для текстов нпубликация листов Letraset с образцами Lorem Ipsum в 60-х годах и, в более недавнее время,
						программы электронной вёрстки типа Aldus PageMaker, в шаблонах которых используется Lorem Ipsum.
					</p>
				</div>
			{/if}
		</div>
	</div>
</div>


{* ПРОСМОТРЕННЫЕ / Боковая часть *}
{get_browsed_products var=browsed_products limit=6}
{if $browsed_products}
<section class="mt-2 mb-3" id="browsed_product">

	<div class="page_header text-center">
		<span>Вы уже просматривали</span> в нашем каталоге
	</div>
	<div class="page_header_text">
		Сохраните понравившиеся товары <a class='color' href='wishlist'>в закладки</a><br />
		Это позволит не потерять понравишийся вариант!
	</div>

	<div class="row items-list">
		{foreach $browsed_products as $browsed_product}
		<div class="col">
			<div class="item">

				{* Изображение *}
				<div class="image">
					{if $browsed_product->image->filename}<img src="{$browsed_product->image->filename|resize:70:70}" alt="{$browsed_product->name|escape}" title="{$browsed_product->name|escape}">
					{else}<svg class="isvg" width="24" height="24">{include file='svg.tpl' item='isvg-noimage'}</svg>{/if}
				</div>

				{* Рейтинг товара в блоке *}
				<div class="disabled product_rating" id="product_{$browsed_product->id}">
					<span class="rating_starOff">
					<span class="rating_starOn" style="width:{$browsed_product->rating*90/5|string_format:'%.0f'}px;"></span>
					</span>
					<span class="rating_text{if $browsed_product->rating==0} hidden{/if}">({$browsed_product->rating|string_format:"%.1f"})</span>
				</div>

				{* Название товара в блоке *}
				<div class="name">{$browsed_product->name|truncate:50:'...'}</div>
				<a class="item-link over-all" data-product="{$browsed_product->id}" href="{$lang_link}products/{$browsed_product->url}"></a>
			</div>
		</div>
		{/foreach}
	</div>

</section>
{/if}



{*=| Связанные статьи и обзоры |=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*}
{if $related_posts}
	<div class="{$smarty.get.module} post_list">
		<div class="page_header" data-language="product_related_post">
			{*$lang->product_related_post*}
			<span>Связанные статьи</span> и новости
		</div>
		<div class="row mx-0">
			{foreach $related_posts as $post}
			<div class="col-sm-6 col-lg-4 col-xl-3{if $post@first} first{/if} post_item anim-all">

				{* Изображение *}
				<a class="post_image" href="{$lang_link}{$post->type_post}/{$post->url}">
					{if $post->image}	<img src="{$post->image|resize:300:300:false:$config->resized_blog_dir}" alt="{$post->name|escape}" title="{$post->name|escape}">
					{else}				<svg class="fn_img isvg" width="44" height="44">{include file='svg.tpl' item='isvg-noimage'}</svg>{/if}
				</a>

				{* Дата создания *}
				<div class="post_date">{$post->date|date}</div>

				<div class="post_content">
					{* Название *}
					<h4 class="title">
						<a href="{$lang_link}{$post->type_post}/{$post->url}" data-post="{$post->id}">{$post->name|truncate:50:'...'}</a>
					</h4>

					{* Краткое описание *}
					{if $post->annotation}
						<div class="post_annotation">
							{$post->annotation|strip_tags|truncate:150:'...'}
						</div>
					{/if}
				</div>

			</div>
			{/foreach}
			<div class="col-12 mb-1">
			<a class="btn btn-light btn-sm" href="{$lang_link}news" data-language="main_all_news">{$lang->main_all_news}</a>
			</div>
		</div>
	</div>
{/if}


{*=| Связанные товары НАЗНАЧЕННЫЕ ВРУЧНУЮ к товару Администратором |=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*}
{if $related_products}
	<div class="page_header" data-language="product_recommended_products">
		{*$lang->product_recommended_products*}
		<span>Рекомендуемые</span>&nbsp;предложения
	</div>

	{if $device==mobile}	{$limit=8}
	{else}					{$limit=10}
	{/if}
	<div class="row {$smarty.get.module} products-grid slick-products">
		{assign var="count" value=0}
		{foreach $related_products as $p}
			{if $count < $limit}
			<div class="col-sm-6 col-md-4 col-lg-3 col-xl-20 products-item">
				{include "product_list.tpl" product = $p}
			</div>
			{/if}
			{$count = $count + 1}
		{/foreach}
	</div>

	{else}	{* ЕСЛИ для открытого НЕТ в ручную назначенных связанных - покажем хиты магазина *}
			{get_featured_products var=featured_products limit=$limit}
			{if $featured_products}
				<div class="page_header text-center"><span>Рекомендуемые</span>предложения</div>

				{if $device==mobile}		{$limit=4}
				{else}						{$limit=8}
				{/if}
				<div class="row {$smarty.get.module} products-grid slick-products featured">
					{foreach $featured_products as $product}
						<div class="col-sm-6 col-md-4 col-lg-3 col-xl-20 products-item">
							{include "product_list.tpl"}
						</div>
					{/foreach}
				</div>
			{/if}

{/if}



{* микроразметка по схеме JSON-LD *}
{literal}
<script type="application/ld+json">
{
"@context": "http://schema.org/",
"@type": "Product",
"name": "{/literal}{$product->name|escape}{literal}",
"image": "{/literal}{$product->image->filename|resize:330:300}{literal}",
"description": "{/literal}{$product->annotation|strip_tags}{literal}",
"mpn": "{/literal}{if $product->variant->sku}{$product->variant->sku}{else}Не указано{/if}{literal}",
{/literal}
{if $brand->name}
{literal}
"brand": {
"@type": "Brand",
"name": "{/literal}{$brand->name|escape}{literal}"
},
{/literal}
{/if}
{if $product->rating > 0}
{literal}
"aggregateRating": {
"@type": "AggregateRating",
"ratingValue": "{/literal}{$product->rating|string_format:'%.1f'}{literal}",
"ratingCount": "{/literal}{$product->votes|string_format:'%.0f'}{literal}"
},
{/literal}
{/if}
{literal}
"offers": {
"@type": "Offer",
"priceCurrency": "{/literal}{$currency->code|escape}{literal}",
"price": "{/literal}{$product->variant->price|convert:'':false}{literal}",
"priceValidUntil": "{/literal}{$smarty.now|date_format:'%Y-%m-%d'}{literal}",
"itemCondition": "http://schema.org/UsedCondition",
"availability": "http://schema.org/InStock",
"seller": {
"@type": "Organization",
"name": "{/literal}{$settings->company_name}{literal}"
}
}
}
</script>
{/literal}