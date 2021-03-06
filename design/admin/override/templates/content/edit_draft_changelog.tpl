<div id="leftmenu">
<div id="leftmenu-design">

<div class="objectinfo">

<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h4>{'Object information'|i18n( 'design/admin/content/edit_draft' )}</h4>

</div></div></div></div></div></div>

<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-bl"><div class="box-br"><div class="box-content">

{* Object ID *}
<p>
<label>{'ID'|i18n( 'design/admin/content/edit_draft' )}:</label>
{$object.id}
</p>

{* Created *}
<p>
<label>{'Created'|i18n( 'design/admin/content/edit_draft' )}:</label>
{section show=$object.published}
{$object.published|l10n( shortdatetime )}<br />
{$object.current.creator.name|wash}
{section-else}
{'Not yet published'|i18n( 'design/admin/content/edit_draft' )}
{/section}
</p>

{* Modified *}
<p>
<label>{'Modified'|i18n( 'design/admin/content/edit_draft' )}:</label>
{section show=$object.modified}
{$object.modified|l10n( shortdatetime )}<br />
{fetch( content, object, hash( object_id, $object.content_class.modifier_id ) ).name|wash}
{section-else}
{'Not yet published'|i18n( 'design/admin/content/edit_draft' )}
{/section}
</p>

{* Published version *}
<p>
<label>{'Published version'|i18n( 'design/admin/content/edit_draft' )}:</label>
{section show=$object.published}
{$object.current_version}
{section-else}
{'Not yet published'|i18n( 'design/admin/content/edit_draft' )}
{/section}
</p>

</div></div></div></div></div></div>

</div>

</div>
</div>

<div id="maincontent"><div id="fix">
<div id="maincontent-design">
<!-- Maincontent START -->

{let has_own_drafts=false()
     has_other_drafts=false()
     current_creator=fetch( user, current_user )
     draft_checked=false()}

{section loop=$draft_versions}
    {section show=eq( $item.creator_id, $current_creator.contentobject_id )}
        {set has_own_drafts=true()}
    {section-else}
        {set has_other_drafts=true()}
    {/section}
{/section}


<div class="message-warning">

<h2><span class="time">[{currentdate()|l10n( shortdatetime )}]</span> {'Possible edit conflict'|i18n( 'design/admin/content/edit_draft' )}</h2>

{section show=and( $has_own_drafts, $has_other_drafts )}
    <p>{'This object is already being edited by someone else. In addition, it is already being edited by you.'|i18n( 'design/admin/content/edit_draft' )}</p>
    <p>{"You should contact the other user(s) to make sure that you are not stepping on anyone's toes."|i18n( 'design/admin/content/edit_draft' )}
    <p>{'The most recently modified draft is version #%version, created by %creator, last changed: %modified.'|i18n( 'design/admin/content/edit_draft',, hash( '%version', $most_recent_draft.version, '%creator', $most_recent_draft.creator.name, '%modified', $most_recent_draft.modified|l10n( shortdatetime ) ) )|wash}</p>
{section-else}

    {section show=$has_own_drafts}
        <p>{'This object is already being edited by you.'|i18n( 'design/admin/content/edit_draft' )}</p>
        <p>{'Your most recently modified draft is version #%version, last changed: %modified.'|i18n( 'design/admin/content/edit_draft',, hash( '%version', $most_recent_draft.version, '%creator', $most_recent_draft.creator.name, '%modified', $most_recent_draft.modified|l10n( shortdatetime ) ) )|wash}</p>
    {/section}

    {section show=$has_other_drafts}
        <p>{'This object is already being edited by someone else.'|i18n( 'design/admin/content/edit_draft' )}</p>
        <p>{"You should contact the other user(s) to make sure that you are not stepping on anyone's toes."|i18n( 'design/admin/content/edit_draft' )}
        <p>{'The most recently modified draft is version #%version, created by %creator, last changed: %modified.'|i18n( 'design/admin/content/edit_draft',, hash( '%version', $most_recent_draft.version, '%creator', $most_recent_draft.creator.name, '%modified', $most_recent_draft.modified|l10n( shortdatetime ) ) )|wash}</p>
    {/section}

{/section}

<p>{'Possible actions'|i18n( 'design/admin/content/edit_draft' )}:</p>
<ul>
    {section show=$has_own_drafts}
        <li>{'Continue editing one of your drafts.'|i18n( 'design/admin/content/edit_draft' )}</li>
    {/section}
    <li>{'Create a new draft and start editing it.'|i18n( 'design/admin/content/edit_draft' )}</li>
    <li>{'Cancel the edit operation.'|i18n( 'design/admin/content/edit_draft' )}</li>
</ul>

</div>




<form method="post" action={concat( '/content/edit/', $object.id )|ezurl}>

<div class="context-block">

{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h2 class="context-title">{'Current drafts [%draft_count]'|i18n( 'design/admin/content/edit_draft',, hash( '%draft_count', $draft_versions|count ) )}</h2>

{* DESIGN: Subline *}<div class="header-subline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">

{section var=Drafts loop=$draft_versions}
{section show=eq( $Drafts.item.creator_id, $current_creator.contentobject_id )}
{set draft_checked=$Drafts.item.id}
{/section}
{/section}

<table class="list" cellspacing="0">
<tr>
   <th class="tight">&nbsp;</th>
    <th>{'Version'|i18n( 'design/admin/content/edit_draft' )}</th>
    <th>{'Translations'|i18n( 'design/admin/content/edit_draft' )}</th>
    <th>{'Creator'|i18n( 'design/admin/content/edit_draft' )}</th>
    <th>{'Created'|i18n( 'design/admin/content/edit_draft' )}</th>
    <th>{'Modified'|i18n( 'design/admin/content/edit_draft' )}</th>
    <th>{'Changes'|i18n( 'design/admin/content/edit_draft' )}</th>
</tr>

{section var=Drafts loop=$draft_versions sequence=array( bglight, bgdark )}
<tr class="{$Drafts.sequence}">

    {* Edit. *}
    <td>
        {section show=eq( $Drafts.item.creator_id, $current_creator.contentobject_id )}
            <input type="radio" name="SelectedVersion" value="{$Drafts.item.version}" {section show=eq( $Drafts.item.id, $draft_checked )}checked="checked"{/section} title="{'Select draft version #%version for editing.'|i18n( 'design/admin/content/edit_draft',, hash( '%version', $Drafts.item.version ) )}" />
        {section-else}
            <input type="radio" name="SelectedVersion" value="{$Drafts.item.version}" disabled="disabled" title="{'You can not select draft version #%version for editing because it belongs to another user. Please select a draft that belongs to you or create a new draft and then edit it.'|i18n( 'design/admin/content/edit_draft',, hash( '%version', $Drafts.item.version ) )}" />
        {/section}
    </td>

    {* Version/view. *}
    <td><a href={concat( '/content/versionview/', $object.id, '/', $Drafts.item.version )|ezurl} title="{'View the contents of version #%version. Default translation: %default_translation.'|i18n( 'design/admin/content/edit_draft',, hash( '%version', $Drafts.item.version, '%default_translation', $object.default_language|locale().intl_language_name ) )}">{$Drafts.item.version}</a></td>

    {* Translation. *}
    <td>
        {section var=Languages loop=$Drafts.item.language_list}
            {delimiter}<br />{/delimiter}
            <img src="{$Languages.item.language_code|flag_icon}" alt="{$Languages.item.language_code}" />&nbsp;<a href={concat('/content/versionview/', $object.id, '/', $Drafts.item.version, '/', $Languages.item.language_code, '/' )|ezurl} title="{'View the contents of version #%version_number. Translation: %translation.'|i18n( 'design/admin/content/edit_draft',, hash( '%translation', $Languages.item.locale.intl_language_name, '%version_number', $Drafts.item.version ) )}" >{$Languages.item.locale.intl_language_name}</a>
        {/section}
    </td>

    {* Creator. *}
    <td>{$Drafts.item.creator.name|wash}</td>

    {* Created. *}
    <td>{$Drafts.item.created|l10n( shortdatetime )}</td>

    {* Modified. *}
    <td>{$Drafts.item.modified|l10n( shortdatetime )}</td>

    {* Changes *}
    <td>{$Drafts.item.data_map.changelog.content|wash( xhtml )|nl2br}</td>

</tr>
{/section}
</table>

{* DESIGN: Content END *}</div></div></div>
<div class="controlbar">
{* DESIGN: Control bar START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
<input type="hidden" name="ContentObjectLanguageCode" value="{$edit_language}" />
<div class="block">
{section show=$has_own_drafts}
<input class="button" type="submit" name="EditButton" value="{'Edit selected'|i18n( 'design/admin/content/edit_draft' )}" title="{'Edit the selected draft.'|i18n( 'design/admin/content/edit_draft' )}" />
{section-else}
<input class="button-disabled" type="submit" name="EditButton" value="{'Edit selected'|i18n( 'design/admin/content/edit_draft' )}" disabled="disabled" title="{'You can not edit any of the drafts because none of them belong to you. Hint: Create a new draft, select it and edit it.'|i18n( 'design/admin/content/edit_draft' )}" />
{/section}

<input class="button" type="submit" name="NewDraftButton" value="{'New draft'|i18n( 'design/admin/content/edit_draft' )}" title="{'Create a new draft. The contents of the new draft will copied from the published version.'|i18n( 'design/admin/content/edit_draft' )}" />
<input class="button" type="submit" name="CancelDraftButton" value="{'Cancel'|i18n( 'design/admin/content/edit_draft' )}" title="{'Cancel the edit operation.'|i18n( 'design/admin/content/edit_draft' )}" />
<input type="hidden" name="DoNotEditAfterNewDraft" value="1" />
</div>
{* DESIGN: Control bar END *}</div></div></div></div></div></div>

</div>
</div>

</form>

{/let}


<!-- Maincontent END -->
</div>
<div class="break"></div>
</div></div>
