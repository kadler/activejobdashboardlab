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

table.tablesorter thead tr th
{
  padding-right: 20px;
}

</style>
<script>
function submit(reset)
{
    $("#sorting").val(JSON.stringify($('#job_info_table').data().tablesorter.sortList));
    console.log($("#sorting").val());
    $('#reset').val(reset);
    $('#action_form').submit();
}

function refresh()
{
    submit(false);
}

function reset()
{
    submit(true);
}

$(document).ready(function() {
    var table = $("#job_info_table");
    var sorting = $("#sorting").val();
    
    table.tablesorter({
        sortList: JSON.parse(sorting)
    });
    
    setTimeout(function() {
      refresh();
    }, 10000);
});

</script>
</head>

<body>
<div id='content'>
<div id='header'>
<h2 id='elapsed_time'>Elapsed time: {{elapsed_time}} seconds</h2>
<span id='actions'>
  <form id='action_form' action='/' method='POST'>
    <input type='hidden' id='sorting' name='sorting' value='{{sorting}}' />
    <input type='hidden' id='reset' name='reset' value='false' />
  </form>
  <button type='submit' onclick='refresh()'>Refresh</button>
  <button type='submit' onclick='reset()'>Reset</button>
</span>
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