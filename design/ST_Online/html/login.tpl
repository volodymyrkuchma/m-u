{* Login page *}

{* The canonical address of the page *}
{$canonical="/user/login" scope=parent}

{* The page title *}
{$meta_title = $lang->login_title scope=parent}

{* The page heading *}
<h1 class="page_header" data-language="login_enter">
	{$lang->login_enter}
</h1>


<div class="row">
	<div class="col-lg-6 col-xl-5 mb-2">
		<div class="mt-1 mb-2">
			Авторизируйтесь для сохранения истории ваших заказов и автоматиченского учета персональной скидки в нашем каталоге. Уточнить скидку можно у менеджера.
		</div>

		<form method="post" class="form clearfix fn_validate_login">

			<div class="form_group">
				{* User's email *}
				<input class="form_input col-md-8" type="text" name="email" value="{$email|escape}" data-language="form_email" placeholder="{$lang->form_email}*" required />
			</div>
			<div class="form_group">
				{* User's password *}
				<input class="form_input col-md-8" type="password" name="password" data-notice="{$lang->form_enter_password}" value="" data-language="form_password" placeholder="{$lang->form_password}*" required />
			</div>
			<div class="form_group mb-0">
				{* Submit button *}
				<input type="submit" class="button px-2" name="login" data-language="login_sign_in" value="{$lang->login_sign_in}">

				{*  Remind password link *}
				<a class="btn btn-light" href="{$lang_link}user/password_remind" data-language="login_remind">{$lang->login_remind}</a>
			</div>
		{* Form error messages *}
		{if $error}
			<div class="msg_error">
				{if $error == 'login_incorrect'}
					<span data-language="{$translate_id['login_error_pass']}">{$lang->login_error_pass}</span>
				{elseif $error == 'user_disabled'}
					<span data-language="login_pass_not_active">{$lang->login_pass_not_active}</span>
				{else}
					{$error|escape}
				{/if}
			</div>
		{/if}
		</form>
	</div>

	<div class="col-lg-6 col-xl-7 py-1 px-lg-2">
		<div class="h3 text-caps" data-language="login_text">
			{$lang->login_text}
		</div>
		<div class="my-1 text-md">
			Для наших постоянных клиентов мы предлагаем зарегистрироваться в нашем каталоге. Выполнив вход, Вы сможете заказывать товары с учетом скидки, назначенной администрацией для вашего аккаунта. Уточнить персональную скидку можно по нашим телефонам. После регистрации у вас появится уникальная возможность получать скидки, подарки и специальные предложения для зарегистрированных пользователей.
		</div>

		{* Link to registration *}
		<a href="{$lang_link}user/register" class="btn btn-light" data-language="login_registration">{$lang->login_registration}</a>
	</div>
</div>