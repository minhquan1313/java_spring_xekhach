<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!--  -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html data-bs-theme="dark" class="h-100">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title><tiles:insertAttribute name="title" /></title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
            crossorigin="anonymous"
        />
        <script
            defer
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
            crossorigin="anonymous"
        ></script>
    </head>
    <body class="h-100 d-flex flex-column">
        <tiles:insertAttribute name="header" />

        <div class="container-fluid">
            <tiles:insertAttribute name="content" />
        </div>

        <tiles:insertAttribute name="footer" />
    </body>
</html>
