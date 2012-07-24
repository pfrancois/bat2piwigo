<?php
/*
//================================================================================
* Setup
//================================================================================
:- To setup this script, simply drop this file anywhere in your website. Then edit the vars in this file
//================================================================================
* Frequently Asked Questions
//================================================================================
:- Q1: The script wont make thumbnails! (NO).
fortement inspire de phalbum http://www.phphq.net/scripts.php?script=phAlbum#phAlbum
/*
//================================================================================
* ! ATTENTION !
//================================================================================
:- Please read the above FAQ before giving up or emailing me. It may sort out your problems!
*/

$album_title=basename(dirname(realpath($_SERVER["PHP_SELF"]))); //The name of this album
$show_files=array('jpg','gif','png','jpeg'); //The array, only show these types of files. case non sensitive
$thumbname="thumbnail";//name of the folder of thumbnail
$ignore_word='-hide'; //Hide files or folder with this string in the name. Example, mypicture-hide.jpg will not be shown.
$table_cells=4; //How many images/folders in each row do you want? // Looks best with 3
//We don't want ugly _'s or -'s to display with the file or folder names do we? No! So, lets take them out.
$find=array('_','-');//liste des trucs a remplacer
$replace=array(' ',' ');//liste des trucs remplaces

$supress_error=false; //Suppress errors if thumb creation fails.  1=hide errors, 0=show errors.

$thumb_width=128;
$text_color='#868284'; // The text color.
$text_size=10; // The text size.
$text_face='Verdana, Arial, sans-serif'; //The text face. Arial, Verdana etc.
$link_color='#868284'; // The link color.
$link_hover='#FFFFFF'; // Link link hover color, you know, when you put your mouse over a link!
$error_color='#FF0000'; //Color for error messages
$bgcolor='#293134'; // Page background color.

$image_border=2; //Do you want a border around the images? 1-10, number of pixels.
$border_color='#000000'; // What color do you want the image border to be?
$admin_enable=True;//si true, il y a la possiblite d'avoir une version admin qui affiche tous les repertoires et les fichiers.

/*
//================================================================================
* Attention
//================================================================================
: Don't edit below this line unless you know some php. Editing some variables or other stuff could cause undeseriable results!!
: This is no joke, I spent lots of time trying to work through everything, this is why I have so many comments in the file.
*/

//Header html.. for css etc.
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title><?php echo $album_title;?></title>
<style type='text/css'>
body{
    background-color:<?php echo $bgcolor;?>;
    font-family: <?php echo $text_face;?>;
    font-size: <?php echo $text_size;?>pt;
    color: <?php echo $text_color;?>;
}

a:link {
    text-decoration:none;
    color:<?php echo $link_color;?>;
}

a:visited {
    text-decoration:none;
    color:<?php echo $link_color;?>;
}

a:hover {
    text-decoration:none;
    color:<?php echo $link_hover;?>;
}

.error{
    font-family: <?php echo $text_face;?>;
    font-size: <?php echo $text_size;?>pt;
    color: <?php echo $error_color;?>;
}

.image{
    border:<?php echo $image_border;?>px solid <?php echo $border_color;?>;
}

input {
    font-family:<?php echo $text_face;?>;
    font-size:<?php echo $text_size;?>px;
    color:<?php echo $text_color;?>;
    border:1px solid <?php echo $border_color;?>;
}
hr {
    color:<?php echo $text_color;?>;
}
</style>
</head>
<body>


<?php
//Start the album script! Lets get it started in here!
function search_replace(/*.string.*/$haystack, /*.string.*/$needles, /*.string.*/$replacement, $offset=0) {
/*  @var $haystack string chaine ou on cherche
    @var $needles string ce qu'on cherche
    @var $replacement string ce qu'ont va remplacer
    @var $offsetint numero de depart
    
    recherche et remplace dans hackstack tous les elements de needles par replacement*/
    
    for($i=0;$i<count($needles);$i++) {
        $found = stripos($haystack, $needles[$i], $offset);
        $haystack=substr_replace($haystack,$replacement[$i],$found+$offset,count($replacement[$i]));
    }
    return ucfirst($haystack);
}
function baseurl(/*.string.*/$url){
/*@var $url url de travail*/
/*renvoie l'url un repertroie plus haut*/
    $temp=explode("/",$url);
    array_pop($temp);
    return implode("/",$temp);
}


//Makes the tables look nice and pretty.

if($table_cells<6) {
    $cell_width= strval((int)(100/$table_cells)).'%';
} else {
    $cell_width='10%';
}

//This is just a random ignore word if none is set above, pretty impossible to be in the filename anyways.

if(!$ignore_word) {
    $ignore_word=microtime();
}
//############################# DISPLAY THE ALBUM###########################


$path=dirname(__FILE__);
//each directory
$base_url=baseurl($_SERVER["SCRIPT_NAME"]);
echo '<div><a href="http://'.$_SERVER['SERVER_NAME'].baseurl($base_url).'"> dossier sup&eacute;rieur</a> </div>';
$f=0;/*variable de comptage du nombre de dossiers*/
if (isset($_GET['francois']) and $_GET['francois']==1) {$admin=true;} else {$admin=false;}
/*affichage des sous repertoires, 1 car il y a automatiquement au moins le repertoire des vignettes*/
if (count(glob($path."/*",GLOB_ONLYDIR))>1) {
    echo('<table style="border:0px;" cellpadding="15" width="98%" align="center">'."\n");
    foreach (glob($path."/*",GLOB_ONLYDIR) as $file){
        $fin_ligne=false;//fin_ligne est la variable afin de savoir si on est a la fin d'une ligne car il faut gerer les lignes et le tableau
        if (is_int($f / $table_cells)) {
            echo("<tr>\n");
        }
        //on gere les exceptions d'affichage
        if (basename($file)!=$thumbname and (stripos($file,$ignore_word)===false or $admin=true)) {
            $f++;
            echo '<td><a href="http://'.$_SERVER['SERVER_NAME'].basename($file).'">'.basename(search_replace($file,$find,$replace)).'</a></td>';
            if(is_int($f / $table_cells)) {
                $fin_ligne=true;
                echo "</tr>\n";
            } else {
                echo '';
            }
        }
    }
    if (!is_int($f / $table_cells) and $fin_ligne==false) {
            echo("</tr>\n");
    }
    echo "</table>\n";
}
echo "<hr size='1' />\n";
//Lets get some images!!
    
//Loop through them all ;).
$base_url="http://".$_SERVER['SERVER_NAME'].$base_url."/";//url complete du site de base avant l'ajout de la reference de la photo
$k=0;//numero de la photo
$image_close=false;
$images="";//chaine de caractere qui va contenir le html crée
$thumb_error="";//cahine de gestion des erreurs
foreach (glob($path."/*") as $file){
    //Don't display the stupid directory tree files.
    $file_name=basename($file);//nom fu fichier image
    if($file!= '.' and $file!='..' and is_dir($file)===false){
        $path_parts=pathinfo($file);
        $file_ext=$path_parts['extension'];//extension du fichier image
        $display_name=search_replace($file_name,$find,$replace);//legende de l'image
        //Hide the thumb files from displaying as regular files and disallow any file types that are not allowed.
        //if the file has the ignore word in it, do not show the file.
        if(in_array(strtolower($file_ext),$show_files) and stripos($file,$ignore_word)===false) {
            if(is_int($k / $table_cells) and $k!=0) {
                $images .= "<tr>\n";
            } else {
                $images .='';
            }  
            //if a thumb file dosen't exists, then report.
            if(!file_exists($path.'/'.$thumbname.'/TN-'.$file_name)) {
                $thumb_error .='Thumb for '.$file.' not created.<br />';
                $thumb=$base_url.'/'.$file_name;
            }else {
                $thumb=$base_url.'/'.$thumbname.'/TN-'.$file_name;
            }
            //Now, if there is a thumb file, display the thumb, else display the full images but smaller :(.
            //Make the html
            $url=$base_url.'/'.$file_name;
            //Image border
            $images .= "<td width='$cell_width' align='center'><a href='$url'><img src='$thumb' style='border:0px;'/><br />$display_name</a><br /></td>\n";
            $k++;
            if(is_int($k / $table_cells)) {
                $images .= "</tr>\n";
            } else {
                $images .='';
            }
        }
    }
}
//si il y a des images on lance le rendering html
if($images) {
    echo("<table style='border:0px;' cellpadding='15' width='98%' align='center'>\n");
    echo("<tr>\n");
    echo($images);
    if(!is_int($k / $table_cells)) {
        echo("</tr>\n");
    }
    echo("</table>\n");

    if($thumb_error && !$supress_error) {
        echo("<div align='center'><span class='error'>The following thumb errors have occured:</span><br /><br /> <b>".$thumb_error."</div>");
    }

} else {//sion pas d'images
    echo("<table style='border:0px;width:100%;' cellpadding='15' align='center'>\n");
    echo("<tr>\n");
    echo("<td align='center'><b>No images to display in this album. Please pick another album.</b></td>");
    echo("</tr>\n");
    echo("</table>\n");
}
?>
</body>
</html>