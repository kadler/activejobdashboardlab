<html>
<head>
<title>Active Job Dashboard</title>
<script src="jquery.min.js"></script>
<script src="jquery.tablesorter.min.js"></script>
<link rel="stylesheet" href="style.css">
<style>
#header
{
    width: 600px;
}

#elapsed_time
{
    display: inline;
    float: left;
}

#actions
{
  float: right;
}

#actions button
{
  display: inline;
}

.clear
{
	clear: both;
}

table.tablesorter thead tr th
{
  padding-right: 20px;
}

#columns
{
	width: 800px;
	-moz-column-count: 3;
	-webkit-column-count: 3;
	column-count: 3;
	display: none;
}

#columns_header:hover
{
	text-decoration: underline;
	cursor: pointer;
}

</style>
<script>
$(document).ready(function() {
    var table = $("#job_info_table");
    var sorting = $("#sorting").val();
    
    table.tablesorter({
        sortList: JSON.parse(sorting)
    });
    
    
	function submit(reset) {
	    $("#sorting").val(JSON.stringify($('#job_info_table').data().tablesorter.sortList));
	    $('#reset_statistics').val(reset);
	    $('#action_form').submit();
	}
	
	$('#refresh_button').click(function() {
	    submit(false);
	});
	
	$('#reset_button').click(function() {
	    submit(true);
	});
	
	
	$('#columns_header').click(function() {
		$('#columns').toggle('slow');
	});
});

</script>
</head>

<body>
<div id='content'>

<form id='action_form' action='/' method='POST'>
<div id='header'>
<h2 id='elapsed_time'>Elapsed time: {{elapsed_time}} seconds</h2>
<span id='actions'>
  <input type='hidden' id='sorting' name='sorting' value='{{sorting}}' />
  <input type='hidden' id='reset_statistics' name='reset' value='false' />
  <button id='refresh_button'>Refresh</button>
  <button id='reset_button'>Reset</button>
</span>
</div>
<h3 class='clear'><span id='columns_header'>Columns to show</span></h3>
<div id='columns'>
% for column in columns:
	% checked = 'checked' if column_info[column] else ''
	<div>
		<input type='checkbox' name='selected_columns' value='{{column}}' id='{{column}}' {{checked}}>
		<label for='{{column}}'>{{column}}</label>
	</div>
% end
</div>

</form>
</div>


<table width="750px" id='job_info_table' class="tablesorter">
<thead>
% include('row', values=headers, header=True)
</thead>
<tbody>
% for row in rows:
	% include('row', values=row, header=False)
% end
</tbody>
</table>
</div>
</body>
</html>