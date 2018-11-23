<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=1.0" />
        <title>基于jquery的手机端对话框特效 - 素材家园</title>
        <!-- <link rel="stylesheet" type="text/css" href="css/mdialog.css"> -->
        <jsp:include page="common.jsp"></jsp:include>
        <style type="text/css">
            input {
                margin: 100px auto;
            }

            input[type="button"] {
                padding: 15px 25px;

            }
        </style>
    </head>

    <body>
        <center>
            <input type="button" id="success" value="成功" />
            <input type="button" id="error" value="错误" />
            <input type="button" id="load" value="正在加载" />
            <input type="button" id="tip" value="提示" />
        </center>

        <!-- <script type="text/javascript" src="jquery-1.11.1.min.js"></script>
        <script type="text/javascript" src="mdialog.js"></script> -->
        <script type="text/javascript">
            //成功  
            $("#success").click(function() {
                new TipBox({
                    setTime: 1500,
                    type: 'success',
                    str: '操作成功',
                    hasBtn: true
                });
            });
            //错误  
            $("#error").click(function() {
                new TipBox({
                    type: 'error',
                    str: '对不起,出错了!',
                    hasBtn: true
                });
            });
            //提示  
            $("#tip").click(function() {
                new TipBox({
                    type: 'tip',
                    str: '这是提示信息',
                    clickDomCancel: true,
                    setTime: 10000500,
                    hasBtn: true
                });
            });
            //加载  
            $("#load").click(function() {
                new TipBox({
                    type: 'load',
                    str: "努力加载中..",
                    setTime: 1500,
                    callBack: function() {
                        new TipBox({
                            type: 'success',
                            str: '操作成功',
                            hasBtn: true
                        });
                    }
                });
            });
        </script>
    </body>

</html>