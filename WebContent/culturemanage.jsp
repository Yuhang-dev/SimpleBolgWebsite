<%@page import="main.java.myblog.po.CultureBean"%>
<%@page import="main.java.myblog.po.FoodBean"%>
<%@page import="main.java.myblog.po.RecordsList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="col-md-7">
	<h3>管理你的数据</h3>
	<h4>“风俗”</h4>
	<div class="dropdown">
		<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
			选择类型
		</button>
		<div class="dropdown-menu">
			<a class="dropdown-item" href="user?actionName=fooddatamanage&foodmanagePage=1">美食</a>
			<a class="dropdown-item" href="user?actionName=resortsdatamanage&resortsmanagePage=1">景点</a>
			<a class="dropdown-item" href="user?actionName=culturedatamanage&culturemanagePage=1">风俗</a>
		</div>
	</div>
	<br>
	<table class="offset-1 table table-hover table-sm" style="text-align:justify;">
		<tbody>
<%
	List<CultureBean> totalList=((RecordsList)session.getAttribute("recordlistbean")).getCultureRecordsList();
	int currentPage=0;
	if(request.getParameter("culturemanagePage")==null){
		currentPage=1;
	}

	else{currentPage=Integer.parseInt(request.getParameter("culturemanagePage"));}
	
	int size=totalList.size();
	List<CultureBean> list=null;
	int pagesize=3;
	
	if(currentPage<1){
		currentPage=1;
	}else if(currentPage>(size+2)/pagesize){
		currentPage=(size+2)/pagesize;
	}
	
	if(currentPage*pagesize>size){
		list=totalList.subList((currentPage-1)*pagesize, size);
	}else{
		list=totalList.subList((currentPage-1)*pagesize, currentPage*pagesize);
	}
	
	
	for(int i=0;i<list.size();i++){
		CultureBean bean=list.get(i);
		out.print("<tr><td>");
		out.print(bean.getCName());
		out.print("<td>");
		out.print(bean.getCInfo());
		out.print("</td><td>");
		out.print("<a href=\"data?actionName=changeCulture&name="
		+bean.getCName()+"\""+"class=\"text-warning\" method=\"post\">");
		out.print("修改</a></td>");
		out.print("<td><a href=\"data?actionName=deleteCulture&name="+bean.getCName()+"\""
		+"class=\"text-danger\" onclick=\"return confirmAction();\" method=\"post\">");
		out.print("删除</a></td></tr>");
	}
	
	out.print("</tbody></table>");
	out.print("</tbody></table><a href=\"user?actionName=culturedatamanage&culturemanagePage="+(currentPage-1)
			+"\" class=\"btn btn-pills btn-primary offset-1\">上一页</a>");
	out.print("</tbody></table><a href=\"user?actionName=culturedatamanage&culturemanagePage="+(currentPage+1)
			+"\" class=\"btn btn-pills btn-primary offset-1\">下一页</a>");
	out.print("</div>");
%>

<script>

	function confirmAction() {
    	if (confirm("是否删除?")) {
        	return true;
    	}

    return false;
};

</script>