$(function() {

    var templateSrc = $('#taskTemplate').html();
    var taskTemplate = Handlebars.compile(templateSrc);

    var loadTasks = function() {
        $.ajax({
            url: "/libs/granite/packaging/rcp",
            type: "GET"
        })
            .success(function(data, textStatus, request) {
                $('#taskContainer').empty();
                for (var u in data.tasks) {
                    var html = taskTemplate(data.tasks[u]);
                    $('#taskContainer').append(html);
                }
            });
    };

    loadTasks();

    $('#create_task').click(function(e) {
        e.preventDefault();

        var suffixes = {};
        suffixes['crx'] = "/crx/server/-/jcr:root";
        suffixes['sling'] = "/server/default/jcr:root";

        var serverMode = $('input[name=server]:checked').val();

        // construct complete source url: username:pwd@url
        var sourceUrl = "http://" + $("input[name='username']").val() + ":";
        sourceUrl += $("input[name='pwd']").val() + "@";
        sourceUrl += $("input[name='srcUrl']").val() + suffixes[serverMode];
        sourceUrl += $("input[name='src']").val();

        var defaultExclude = $("input[name='src']").val() + "(/.*)?/rep:policy";

        var data = {
            "cmd": "create",
            "id": $('input[name=id]').val(),
            "src": sourceUrl,
            "dst": $('input[name=dst]').val(),
            "batchsize": $('input[name=batchsize]').val(),
            "update": $('input[name=update]').is(':checked'),
            "onlyNewer": $('input[name=onlyNewer]').is(':checked'),
            "recursive": $('input[name=recursive]').is(':checked'),
            "throttle": $('input[name=throttle]').val(),
            "excludes": [
                defaultExclude
            ]
        };
        var jsonString = JSON.stringify(data);

        $.ajax({
            url: "/libs/granite/packaging/rcp",
            type: "POST",
            contentType: "application/json",
            dataType: "json",
            data: jsonString
        })
            .complete(function(request, textStatus) {
                console.log("textStatus: " + textStatus);
                console.log("request.status: " + request.status);

                $('#createTask').modal('toggle');
                loadTasks();
            });
    });

    $('#createTask').on('hidden.bs.modal', function() {
        $(this).find('form')[0].reset();
    });

    $('#notification div.modal').on('hidden.bs.modal', function() {
        $(this).find('h4.modal-title').empty();
        $(this).find('div.modal-body').empty();
    });

    $('#taskContainer').on('click', '.tasktoolbar button', function() {
        var operation;
        var opString;
        var taskId = $(this).parent('.tasktoolbar').attr('id');
        var buttonSpan = $(this).children('span.glyphicon');
        if (buttonSpan.hasClass("glyphicon-play")) {
            operation = "start";
            opString = "started";
        } else if (buttonSpan.hasClass("glyphicon-stop")) {
            operation = "stop";
            opString = "stopped";
        } else if (buttonSpan.hasClass("glyphicon-trash")) {
            operation = "remove";
            opString = "stopped and deleted";
        }

        console.log("operation: " + operation);
        console.log("taskId: " + taskId);

        var data = {
            "cmd": operation,
            "id": taskId
        };
        var jsonString = JSON.stringify(data);

        $.ajax({
            url: "/libs/granite/packaging/rcp",
            type: "POST",
            contentType: "application/json",
            dataType: "json",
            data: jsonString
        })
            .complete(function(request, textStatus) {
                console.log("textStatus: " + textStatus);
                console.log("request.status: " + request.status);

                var modalTitle = "Task " + taskId + " " + opString;
                var output = request.statusText + " - " + request.status + "<br>" + request.responseText;
                $('#notification h4.modal-title').append(modalTitle);
                $('#notification div.modal-body').append(output);
                $('#notification div.modal').modal();

                loadTasks();
            });
    });

});
