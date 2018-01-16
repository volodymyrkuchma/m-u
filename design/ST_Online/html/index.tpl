{include file='!config.tpl'}
<!DOCTYPE html>
<html {if $language->label}lang="{$language->href_lang|escape}"{/if} prefix="og: http://ogp.me/ns#">
<head>
	{* Full base address *}
	<base href="{$config->root_url}/">

	{* Title *}
    <title>{$meta_title|escape}{$filter_meta->title|escape}</title>

	{* Meta tags *}
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    {if (!empty($meta_description) || !empty($meta_keywords) || !empty($filter_meta->description) || !empty($filter_meta->keywords)) && !$smarty.get.page}
        <meta name="description" content="{$meta_description|escape}{$filter_meta->description|escape}">
        <meta name="keywords" content="{$meta_keywords|escape}{$filter_meta->keywords|escape}">
    {/if}

	{if $module == 'ProductsView'}
        {if $set_canonical}
		    <meta name="robots" content="noindex,nofollow">
        {elseif $smarty.get.page || $smarty.get.sort}
            <meta name="robots" content="noindex,follow">
        {elseif isset($smarty.get.keyword)}
            <meta name="robots" content="noindex,follow">
        {else}
            <meta name="robots" content="index,follow">
        {/if}
    {elseif $smarty.get.module == "RegisterView" || $smarty.get.module == "LoginView" || $smarty.get.module == "UserView" || $smarty.get.module == "CartView"}
        <meta name="robots" content="noindex,follow">
    {elseif $smarty.get.module == "OrderView"}
        <meta name="robots" content="noindex,nofollow">
    {else}
        <meta name="robots" content="index,follow">
	{/if}

	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="generator" content="OkayCMS {$config->version}">

    {if $settings->g_webmaster}
        <meta name="google-site-verification" content="{$settings->g_webmaster}">
    {/if}

    {if $settings->y_webmaster}
        <meta name='yandex-verification' content="{$settings->y_webmaster}">
    {/if}

	{$rel_prev_next}

	{* Product image/Post image for social networks *}
    {if $module == 'ProductView'}
        <meta property="og:url" content="{$config->root_url}{if $lang_link}/{str_replace('/', '', $lang_link)}{/if}{$canonical}">
        <meta property="og:type" content="article">
        <meta property="og:title" content="{$product->name|escape}">
        <meta property="og:description" content='{$product->annotation|strip_tags}'>
        <meta property="og:image" content="{$product->image->filename|resize:330:300}">
        <link rel="image_src" href="{$product->image->filename|resize:330:300}">
        {*twitter*}
        <meta name="twitter:card" content="summary">
        <meta name="twitter:title" content="{$product->name|escape}">
        <meta name="twitter:description" content="{$product->annotation|strip_tags}">
        <meta name="twitter:image" content="{$product->image->filename|resize:330:300}">
    {elseif $module == 'BlogView'}
        <meta property="og:url" content="{$config->root_url}{if $lang_link}/{str_replace('/', '', $lang_link)}{/if}{$canonical}">
        <meta property="og:type" content="article">
        <meta property="og:title" content="{$post->name|escape}">
        {if $post->image}
            <meta property="og:image" content="{$post->image|resize:400:300:false:$config->resized_blog_dir}">
            <link rel="image_src" href="{$post->image|resize:400:300:false:$config->resized_blog_dir}">
        {else}
            <meta property="og:image" content="{$config->root_url}/design/{$settings->theme}/images/logo.png">
            <meta name="twitter:image" content="{$config->root_url}/design/{$settings->theme}/images/logo.png">
        {/if}
        <meta property="og:description" content='{$post->annotation|strip_tags}'>
        {*twitter*}
        <meta name="twitter:card" content="summary">
        <meta name="twitter:title" content="{$post->name|escape}">
        <meta name="twitter:description" content="{$post->annotation|strip_tags}">
        <meta name="twitter:image" content="{$post->image|resize:400:300:false:$config->resized_blog_dir}">
    {else}
        <meta property="og:title" content="{$settings->site_name|escape}">
        <meta property="og:type" content="website">
        <meta property="og:url" content="{$config->root_url}">
        <meta property="og:image" content="{$config->root_url}/design/{$settings->theme}/images/logo.png">
        <meta property="og:site_name" content="{$settings->site_name|escape}">
        <meta property="og:description" content="{$meta_description|escape}">
        <link rel="image_src" href="{$config->root_url}/design/{$settings->theme}/images/logo.png">
        {*twitter*}
        <meta name="twitter:card" content="summary">
        <meta name="twitter:title" content="{$settings->site_name|escape}">
        <meta name="twitter:description" content="{$meta_description|escape}">
        <meta name="twitter:image" content="{$config->root_url}/design/{$settings->theme}/images/logo.png">
    {/if}

	{* The canonical address of the page *}
	{if isset($canonical)}
        <link rel="canonical" href="{$config->root_url}{if $lang_link}/{str_replace('/', '', $lang_link)}{/if}{$canonical}">
	{elseif $smarty.get.sort}
		<link rel="canonical" href="{$sort_canonical}">
    {/if}

	{* Language attribute *}
    {foreach $languages as $l}
		{if $l->enabled}
            <link rel="alternate" hreflang="{$l->href_lang}" href="{$config->root_url}/{$l->url}">
		{/if}
	{/foreach}

	{* Favicon *}
	<link href="design/{$settings->theme}/images/favicon/favicon.ico" type="image/x-icon" rel="icon">
	<link href="design/{$settings->theme}/images/favicon/favicon.ico" type="image/x-icon" rel="shortcut icon">

	{* JQuery *}
	<script src="design/{$settings->theme}/js/jquery-2.1.4.min.js"></script>
	<script src="design/{$settings->theme}/js/jquery.queryloader2.min.js"></script>

    {* Fonts*}
    <link href="//fonts.googleapis.com/css?family=Open+Sans:300,400,600,700&amp;subset=cyrillic" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Oswald:300,400,500&amp;subset=cyrillic" rel="stylesheet">

	{* CSS *}
	<link href="design/{$settings->theme|escape}/css/main.css" rel="stylesheet">
	<link href="design/{$settings->theme|escape}/css/style.css" rel="stylesheet">

    {* Google Analytics *}
    {if $settings->g_analytics}
    {literal}
        <script>
            (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
            })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

            ga('create', {/literal}'{$settings->g_analytics}'{literal}, 'auto');
            ga('send', 'pageview');
        </script>
    {/literal}
    {/if}

    {*if $settings->head_custom_script}
        {$settings->head_custom_script}
    {/if*}

</head>
<body class="{$device} {$module}">
{* <script type="text/javascript">$("body").queryLoader2();</script>*}
<div class="page{if $boxed} boxed{/if}">
	<div class="wrapper">

		{* Шапка *}
		<header id=header>
			<div class="topline">
				<div class="container">
					<div class="row">
						<div class="col">
							{* Меню страниц *}
							<a class="open hidden-lg-up" href="#pages_top">
								<svg class="isvg" width="24" height="24">{include file='svg.tpl' item='isvg-menu'}</svg>
								<span class="hidden-sm-down">Информация</span>
							</a>

							<nav id="pages_top">
								<a class="close" href="#">
								<svg class="isvg" width="20" height="20">{include file='svg.tpl' item='isvg-close'}</svg>
								</a>
								<ul>
								{foreach $pages as $p}
									{if $p->menu_id==1 && $p->url}
										<li>
											<a {if $page && $page->id==$p->id}class="selected disabled" {/if}data-page="{$p->id}" href="{$lang_link}{$p->url}">{$p->name|escape}</a>
										</li>
									{/if}
								{/foreach}
								</ul>
							</nav>
						</div>

						<div class="col col-9 col-sm-8 col-md-7 col-lg-7 col-xl-6 text-right informers_top">

							{* Wishlist informer *}
							<span id="wishlist">
								{include file="wishlist_informer.tpl"}
							</span>

							{* Comparison informer *}
							<span id="comparison">
								{include "comparison_informer.tpl"}
							</span>

							{* Языки *}
							{if $languages|count > 1}
								{$cnt = 0}
								{foreach $languages as $ln}{if $ln->enabled}{$cnt = $cnt+1}{/if}{/foreach}
								{if $cnt>1}
								<span class="drop_block languages">
									<span class="drop_btn">
										<img src="design/{$settings->theme|escape}/images/flags/{$language->label}.png" alt=""/>
										<!-- <span class="hidden-lg-down">&nbsp;{$language->name} /{$language->label}</span> -->
										<svg class="isvg" width="16" height="16">{include file='svg.tpl' item='isvg-arrow_d'}</svg>
									</span>
									<div class="drop_list">
										{foreach $languages as $l}
										{if $l->enabled}
											<a class="item{if $language->id == $l->id} active{/if}" href="{$l->url}">{$l->{'name_'|cat:$language->label}} {*$l->label*}</a>
										{/if}
										{/foreach}
									</div>
								</span>
								{/if}
							{/if}

							{* Выбор валюты *}
							{if $currencies|count > 1}
							<span class="drop_block currencies">
								<span class="drop_btn">
									<!-- <span class="hidden-lg-down">{$currency->name} /</span> -->
									{$currency->sign}
									<svg class="isvg" width="16" height="16">{include file='svg.tpl' item='isvg-arrow_d'}</svg>
								</span>
								<div class="drop_list">
									{foreach $currencies as $c}
									{if $c->enabled}
									<a class="item{if $currency->id== $c->id} disabled{/if}" href="{url currency_id=$c->id}">{$c->name}</a>
									{/if}
									{/foreach}
								</div>
							</span>
							{/if}

							{* Вход / Регистрация *}
							<span>
								<a href="{$lang_link}user">
								<span class="hidden-md-down">{if $user}Мои заказы{else}Вход/Регистрация{/if}</span>
								<svg class="isvg" width="16" height="16">{include file='svg.tpl' item='isvg-user_login'}</svg>
								</a>
							</span>
						</div>
					</div>
				</div>
			</div>

			<div class="contentline py-1">
				<div class="container">
					<div class="row y-middle">
						{* Логотип *}
						<div class="col-12 col-md-8 col-lg-3 col-xl-4 logo text-center text-md-left y-middle">
							<a class="mx-auto mx-sm-0{if $module=="MainView"} disabled{/if}" href="{$lang_link}">
								<img src="design/{$settings->theme|escape}/images/logo{if $languages|count>1}_{$language->label}{/if}.png" alt="{$settings->site_name|escape}"/>
							</a>
							{*<div class="message">Здесь покупают качественные<br />товары по низким ценам!</div>*}
						</div>

						{* Телефоны *}
						<div class="col-6 col-md-4 col-lg-2 col-xl-2 top_phones">
							<div class="phones y-middle">
								<svg class="isvg" width="26" height="24">{include file='svg.tpl' item='phone_header'}</svg>
								<div class="pl-sm">
									<a class="num" href="tel:{$phone_1|strip_tags:''}">{$phone_1}</a>
									{if $phone_2}<a class="num" href="tel:{$phone_2|strip_tags:''}">{$phone_2}</a>{/if}
								</div>
							</div>
						</div>

						{* Поиск *}
						<div class="col-12 col-md-8 col-lg-4 col-xl-4 search">
							<form id="search" action="{$lang_link}all-products">
								<input type="text" name="keyword" value="{$keyword|escape}" data-language="index_search" placeholder="{$lang->index_search}"/>
								<button type="submit">
									<svg class="isvg" width="26" height="36">{include file='svg.tpl' item='isvg-search'}</svg>
								</button>
							</form>
						</div>

						{* информеры *}
						<div class="col-6 col-md-4 col-lg-3 col-xl-2 informers">
							{* Информер корзины / отдаётся аяксом *}
							<div id="cart_informer" class="informer">{include file='cart_informer.tpl'}</div>
						</div>
					</div>
				</div>
			</div>

			<div class="categories">
				<div class="container">
					<nav class="row lev_0">
						<a class="col-12 col-sm-6 col-lg-3 drop_btn">
							<svg class="isvg" width="24" height="24">{include file='svg.tpl' item='isvg-menu'}</svg>
							<span class="pl-1 pr-sm">каталог</span>
							<svg class="isvg" width="26" height="26">{include file='svg.tpl' item='isvg-arrow_d'}</svg>
						</a>{include file="categories2.tpl"}
						<a class='col-6 col-sm-4 col-lg-2' href='discounted'>
							<svg class="isvg mr-sm" width="24" height="24">{include file='svg.tpl' item='sale_menu'}</svg>
							<span>Скидки</span>
						</a>
						<a class='col-6 col-sm-4 col-lg-2' href='bestsellers'>
							<svg class="isvg mr-sm" width="24" height="24">{include file='svg.tpl' item='hitst_menu'}</svg>
							<span>Популярные</span>
						</a>
						<a class='col-6 col-sm-4 col-lg-2 hidden-xs-down' href='kak-kupit'>
							<svg class="isvg mr-sm" width="24" height="24" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg">
							<path fill="currentColor" d="M50.625 53.375v-42.75h-5.25v8h-26.75v-8h-5.25v42.75h37.25zM32 5.375c-1.5 0-2.625 1.125-2.625 2.625s1.125 2.625 2.625 2.625 2.625-1.125 2.625-2.625-1.125-2.625-2.625-2.625zM50.625 5.375c2.875 0 5.375 2.375 5.375 5.25v42.75c0 2.875-2.5 5.25-5.375 5.25h-37.25c-2.875 0-5.375-2.375-5.375-5.25v-42.75c0-2.875 2.5-5.25 5.375-5.25h11.125c1.125-3.125 4-5.375 7.5-5.375s6.375 2.25 7.5 5.375h11.125z"></path>
							</svg>
							<span>Как купить</span>
						</a>
						<a class='col-12 col-sm-6 col-lg-3 fn_callback' href="#fn_callback">
							<svg class="isvg mr-sm" width="22" height="22">{include file='svg.tpl' item='phone_callback'}</svg>
							<span>Заказать звонок</span>
						</a>
					</nav>
				</div>
			</div>
		</header>


		{* Рекламный блок *}
		{if $device==desktop || $device==tablet}
			{get_banner var=banner_STOk2_170714 group='STOk2_170714'}
			{if $banner_STOk2_170714->items}
				<section class="hidden-xs-down" id="banner_1_bg100vw">
				{foreach $banner_STOk2_170714->items as $bi}
					<div class="overlay">
						{if $bi->image}<img class="b-img" src="{$config->banners_images_dir}{$bi->image}" alt=""/>{/if}
						{if $bi->name || $bi->description}
						<div class="container b-content{if $bi->description} description{/if}">
							{if $bi->name}
							<div class="h1">{$bi->name}</div>
							{/if}

							{if $bi->description}
							<div class="hidden-sm-down">{$bi->description|strip_tags|truncate:200:'...'}</div>
							{/if}
						</div>
						{/if}
						{if $bi->urlf}<a class="overlay" href='{$bi->url}'></a>{/if}
					</div>
				{/foreach}
				</section>


										{* ЕСЛИ группа баннеров не задана, это заглушка для демо. на рабочем сайте можно удалить ELSE условие *}
										{else if $module=="MainView"}
											<section class="hidden-xs-down" id="banner_1_bg100vw">
												{* Пример баннера 1 БЕЗ настроек *}
												<div class="overlay">
													<img class="b-img" src="design/{$settings->theme}/images/banners/banner_index_01.jpg" alt=""/>
													<div class="container b-content description">
														<div class="h1">Заголовок баннера для примера</div>
														<div class="hidden-sm-down">Lorem Ipsum не только успешно пережил без заметных изменений пять веков, но и перешагнул в электронный дизайн.</div>
													</div>
													<a class="overlay" href=''></a>
												</div>
												{* Пример баннера 2 БЕЗ настроек *}
												<div class="overlay">
													<img class="b-img" src="design/{$settings->theme}/images/banners/banner_index_02.jpg" alt=""/>
													<div class="container b-content description">
														<div class="h1">Заголовок 222</div>
														<div class="hidden-sm-down">заметных изменений пять веков, но и перешагнул в электронный дизайн.</div>
													</div>
													<a class="overlay" href=''></a>
												</div>
											</section>
			{/if}
		{/if}



		{* Хлебные крошки *}
		{if $module != "MainView"}
			{include file='breadcrumb.tpl'}
		{/if}


		{* Контент и выборочное наполнение, в зависимости от открытого модуля *}
		<div id="fn_content" class="main">
			{if $module == "MainView"}
				{$content}
			{else}
				<div class="container fn_ajax_content">
					{$content}
			   </div>
			{/if}
		</div>


		{* Мы принимаем к оплате *}
		{if in_array ( $module, array(MainView, ProductsView, ProductView, PageView)) && $device != mobile}
		<section class="payments py-2 text-center">
			<div class="container">
				<div class="h4">Принимаем к оплате</div>
				<img src="design/{$settings->theme}/images/payments.png" alt="visa" title="visa">
			</div>
		</section>
		{/if}


		{* Карта перед подвалом *}
		{if in_array ( $module, array(FeedbackView))}
		<div class="ya_map">
			<script async type="text/javascript" charset="utf-8" src="https://api-maps.yandex.ru/services/constructor/1.0/js/?sid=33OLs0Ell3u6mHqRQPSPPzVoGoVJGLmo&width=100%&height=300&lang={$lang->yandex_map_lang}&sourceType=constructor"></script>
		</div>
		{/if}

		{* Подвал *}
		<footer id=footer>
			<div class="footer_main">
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-lg-4">
							{* Subscribing *}
							<div id="subscribe_container">
								<div class="title" data-language="subscribe_heading">
									{$lang->subscribe_heading}
								</div>

								<form class="subscribe_form fn_validate_subscribe" method="post">
									<input type="hidden" name="subscribe" value="1"/>
									<input class="subscribe_input" type="email" name="subscribe_email" value="" data-format="email" data-notice="{$lang->form_enter_email}" placeholder="{$lang->form_email}"/>
									<button class="subscribe_button" type="submit" data-language="subscribe_button">
										{$lang->subscribe_button}
										<svg class="isvg" width="26" height="18">{include file='svg.tpl' item='subscribe_button'}</svg>
									</button>
								</form>

								{if $subscribe_error}
									<div id="subscribe_error" class="popup p-2 text-center">
										{if $subscribe_error == 'email_exist'}
											<span data-language="subscribe_already">{$lang->index_subscribe_already}</span>
										{/if}
										{if $subscribe_error == 'empty_email'}
											<span data-language="form_enter_email">{$lang->form_enter_email}</span>
										{/if}
									</div>
								{/if}
								{if $subscribe_success}
									<div id="fn_subscribe_sent" class="popup p-2 text-center">
										<span data-language="subscribe_sent">{$lang->index_subscribe_sent}</span>
									</div>
								{/if}

								<div class="text" data-language="subscribe_promotext">
									{*$lang->subscribe_promotext*}
									Получайте только полезные статьи и новости о наших скидках!<br />
									Мы не занимаемся рассылкой спама.
								</div>
							</div>

							{* Social buttons *}
							<div class="title" data-language="index_in_networks">{$lang->index_in_networks}</div>
							<div class="dayz_social">
								<a class="fb" href="https://facebook.com/okaycms" target="_blank" title="Facebook"></a>
								<a class="vk" href="https://vk.com/club72497645" target="_blank" title="В контакте"></a>
								<a class="ok" href="{$lang_link}#" target="_blank" title="Одноклассники"></a>
								<a class="tw" href="https://twitter.com/okaycms" target="_blank" title="Twitter"></a>
								<a class="ins" href="{$lang_link}#" target="_blank"  title="Instagram"></a>
							</div>
						</div>


						{* Main menu *}
						<div class="col-sm-6 col-lg-2">
							<div class="title" data-language="index_about_store">
								{$lang->index_about_store}
							</div>
							<div class="footer_menu">
								{foreach $pages as $p}
									{if $p->menu_id == 1 && $p->url}
									<a class="item dotted" href="{$lang_link}{$p->url}">{$p->name|escape}</a>
									{/if}
								{/foreach}
							</div>
						</div>


						{* Categories menu *}
						<div class="col-sm-6 col-lg-3">
							<div class="title" data-language="index_categories">
								{*$lang->index_categories*}
								Основные разделы
							</div>
							<div class="footer_menu">
								{$cnt = 0}
								{foreach $categories as $c}
									{if $c->visible && $cnt<8}
										<a class="item dotted" href="{$lang_link}catalog/{$c->url}">{$c->name|escape|truncate:40:'...'}</a>
										{$cnt = $cnt+1}
									{/if}
								{/foreach}
							</div>
						</div>


						{* Contacts *}
						<div class="col-sm-6 col-lg-3">
							<div class="title" data-language="index_contacts">
								{$lang->index_contacts}
							</div>
							<div class="footer_menu contacts">
								{if $phone_1}
									<a class="item" href="tel:{$phone_1|strip_tags:''}">
										<svg class="isvg" width="18" height="18">{include file='svg.tpl' item='phone_4content'}</svg>
										{$phone_1}
									</a>
								{/if}
								{if $phone_2}
									<a class="item" href="tel:{$phone_2|strip_tags:''}">
										<svg class="isvg" width="18" height="18">{include file='svg.tpl' item='phone_4content'}</svg>
										{$phone_2}
									</a>
								{/if}
								{if $email}
									<a class="item" href="mailto:{$email}">
										<svg class="isvg" width="18" height="18">{include file='svg.tpl' item='email'}</use></svg>
										Email: {$email}
									</a>
								{/if}
								{if $skype}
									<a class="item" href="skype:{$skype}">
										<svg class="isvg" width="18" height="18">{include file='svg.tpl' item='skype'}</svg>
										Skype: {$skype}
									</a>
								{/if}
								{if $firm_adress_footer}
									<div class="item">
										<svg class="isvg" width="18" height="18">{include file='svg.tpl' item='map_marker'}</svg>
										{$firm_adress_footer}
									</div>
								{/if}
								{if $firm_OGRN}
									<div class="item">
										<svg class="isvg" width="18" height="18">{include file='svg.tpl' item='doc_blank'}</svg>
										ОГРН: {$firm_OGRN}
									</div>
								{/if}
							</div>
						</div>
					</div>

					<div class="copyright">
						<div class="mb-sm">© {if $smarty.now|date_format:"%Y" > {$siteY} }{$siteY}-{$smarty.now|date_format:"%Y"}{else}{$siteY}{/if} {$settings->company_name}.</div>
						Данный сайт носит исключительно информационный характер и ни при каких обстоятельствах не является публичной офертой, определяемой положениями Статьи 437 Гражданского кодекса РФ. Точные данные о наличии, ценах и способах приобретения необходимо узнавать у менеджеров магазина по телефону, запросом по электронной почте, через форму обратной связи или при оформлении заказа. Представленная на сайте информация является объектами авторского права "{$settings->site_name}". Любое использование информации должно быть согласовано с администрацией данного интернет-магазина.
					</div>

					{* Просьба не удалять ссылку на наш сайт. *}
					<a class="des_by" title='Создание и оформление великолепных интернет-магазинов - www.Simpla-Template.ru' target='blank' href='http://Simpla-Template.ru/'>© 2017 SimplaTemplate ™</a>
				</div>
			</div>
		</footer>
	</div>
	<a href='#' class='scroll_top anim-all'><svg class="isvg" width="26" height="26">{include file='svg.tpl' item='scroll_top'}</svg></a>
</div>





{include file="svg.tpl" scope=parent}


{if $settings->body_custom_script}
    {$settings->body_custom_script}
{/if}


{* Форма обратного звонка *}
{include file='callback.tpl'}








{* template scripts |=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*}
<script src="design/{$settings->theme}/js/jquery-ui.min.js"></script>
<script src="design/{$settings->theme}/js/main.js"></script>
{include file="scripts.tpl"}
<script src="design/{$settings->theme}/js/custom.js"></script>




{* Yandex метрика / номер указывается в настройках сайта *}
{if $settings->yandex_metrika_counter_id}
    {literal}
    <!-- Yandex.Metrika counter -->
    <script type="text/javascript">
        (function (d, w, c) {
            (w[c] = w[c] || []).push(function() {
                try {
                    w.yaCounter{/literal}{$settings->yandex_metrika_counter_id}{literal} = new Ya.Metrika({
                        id:{/literal}{$settings->yandex_metrika_counter_id}{literal},
                        clickmap:true,
                        trackLinks:true,
                        accurateTrackBounce:true,
                        webvisor:true,
                        trackHash:true,
                        ecommerce:"dataLayer"
                    });
                } catch(e) { }
            });

            var n = d.getElementsByTagName("script")[0],
                    s = d.createElement("script"),
                    f = function () { n.parentNode.insertBefore(s, n); };
            s.type = "text/javascript";
            s.async = true;
            s.src = "https://mc.yandex.ru/metrika/watch.js";

            if (w.opera == "[object Opera]") {
                d.addEventListener("DOMContentLoaded", f, false);
            } else { f(); }
        })(document, window, "yandex_metrika_callbacks");
    </script>
    <!-- /Yandex.Metrika counter -->
{/literal}
{/if}



{* Yandex кнопки соцсетей *}
{if $smarty.get.module == 'ProductView' || $smarty.get.module == "BlogView"}
    <script type="text/javascript" src="//yastatic.net/es5-shims/0.0.2/es5-shims.min.js" defer></script>
    <script type="text/javascript" src="//yastatic.net/share2/share.js" defer></script>
{/if}

{* Всплывающие подсказки для администратора *}
{if $smarty.session.admin}
    <script src ="backend/design/js/admintooltip/admintooltip.js"></script>
    <link href="backend/design/js/admintooltip/styles/admin.css" rel="stylesheet">
{/if}




{* dadata token для демо/бесплатный для примера *}
<link href="https://cdn.jsdelivr.net/npm/suggestions-jquery@17.5.0/dist/css/suggestions.min.css" type="text/css" rel="stylesheet" />
<!--[if lt IE 10]>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-ajaxtransport-xdomainrequest/1.0.1/jquery.xdomainrequest.min.js"></script>
<![endif]-->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/suggestions-jquery@17.5.0/dist/js/jquery.suggestions.min.js"></script>
<script type="text/javascript">
    $("form input[name='name']").suggestions({
        token: "75ada7ca639b0e0495818f2635648b3c9ebc5f1c",
        type: "NAME"
    });
    $("form input[name='address']").suggestions({
        token: "75ada7ca639b0e0495818f2635648b3c9ebc5f1c",
        type: "ADDRESS"
    });
    $("form input[name='email']").suggestions({
        token: "75ada7ca639b0e0495818f2635648b3c9ebc5f1c",
        type: "EMAIL"
    });
</script>




{if "design/[DEMO_INCL]/demo.tpl"|file_exists}{include file="design/[DEMO_INCL]/demo.tpl"}{/if}{* переменные для шаблона *}

</body>
</html>