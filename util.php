<?php

function init_php_session()
{
    if (!session_id()) {
        session_start();
    }
}

function clean_php_session() : void
{
    session_unset();
    session_destroy();
}

function is_logged() : bool
{
    return isset($_SESSION['authenticated']) && $_SESSION['authenticated'] === true;
}

function is_admin() : bool
{
    return true;   
}