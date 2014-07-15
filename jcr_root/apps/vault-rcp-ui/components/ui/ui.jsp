<!DOCTYPE html>
<html>
    <head>
        <title>vault-rcp UI</title>
        <link rel="stylesheet" href="/apps/vault-rcp-ui/components/ui/main.css">

        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

        <!-- Optional theme -->
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
    </head>

    <body>
        <div class="container">
            <h1><span class="glyphicon glyphicon-transfer"></span> Manage vault-rcp tasks</h1>
            <div class="row">
                <button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#createTask">
                    Create task
                </button>
            </div>
            <div id="taskContainer" class="row"></div>
            <div id="notification">
                <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                  <div class="modal-dialog">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title"></h4>
                      </div>
                      <div class="modal-body"></div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                      </div>
                    </div>
                  </div>
                </div>
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="createTask" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">Create task</h4>
              </div>
              <div class="modal-body">
                <form class="form-horizontal" role="form">
                  <div class="form-group">
                    <label for="id_field" class="col-sm-2 control-label">ID</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" id="id_field" name="id" placeholder="enter task id">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="source_field" class="col-sm-2 control-label">Source URL</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" id="source_field" name="srcUrl" placeholder="enter source url">
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label">Server type</label>
                    <div class="col-sm-10">
                        <div class="btn-group" data-toggle="buttons">
                          <label class="btn btn-primary active btn-sm">
                            <input type="radio" name="server" checked value="crx">CRX
                          </label>
                          <label class="btn btn-primary btn-sm">
                            <input type="radio" name="server" value="sling">Sling
                          </label>
                        </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="username_field" class="col-sm-2 control-label">User name</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" id="username_field" name="username" placeholder="enter user name">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="password_field" class="col-sm-2 control-label">Password</label>
                    <div class="col-sm-10">
                      <input type="password" class="form-control" id="password_field" name="pwd" placeholder="enter password">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="source_path_field" class="col-sm-2 control-label">Source path</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" id="source_path_field" name="src" placeholder="enter source path">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="destination_path_field" class="col-sm-2 control-label">Destination path</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" id="destination_path_field" name="dst" placeholder="enter destination path">
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                      <div class="checkbox">
                        <label>
                          <input type="checkbox" name="recursive" checked> Recursive
                        </label>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                      <div class="checkbox">
                        <label>
                          <input type="checkbox" name="update"> Update
                        </label>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                      <div class="checkbox">
                        <label>
                          <input type="checkbox" name="onlyNewer"> Only newer
                        </label>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="batchsize_field" class="col-sm-2 control-label">Batch size</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" id="batchsize_field" name="batchsize" value="1024">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="throttle_field" class="col-sm-2 control-label">Source path</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" id="throttle_field" name="throttle" value="0">
                    </div>
                  </div>
                </form>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" id="create_task">Save</button>
              </div>
            </div>
          </div>
        </div>

        <script id="taskTemplate" type="text/x-handlebars-template">
            <div class="panel panel-default">
              <div class="panel-heading">
                <a data-toggle="collapse" data-target="#task_{{id}}">{{id}}</a> <span class="label label-default">{{status.state}}</span>
                <div id="{{id}}" class="pull-right tasktoolbar">
                    <button type="button" class="btn btn-default btn-xs">
                        <span class="glyphicon glyphicon-play"></span>
                    </button>
                    <button type="button" class="btn btn-default btn-xs">
                        <span class="glyphicon glyphicon-stop"></span>
                    </button>
                    <button type="button" class="btn btn-default btn-xs">
                        <span class="glyphicon glyphicon-trash"></span>
                    </button>
                </div>
              </div>
              <div id="task_{{id}}" class="panel-body collapse">
                <div class="details">
                    <div>
                        Source: {{src}}
                    </div>
                    <div>
                        Destination: {{dst}}
                    </div>
                    <div>
                        Recursive: {{#if recursive}}true{{else}}false{{/if}}
                    </div>
                    <div>
                        Save batch size: {{batchsize}}
                    </div>
                    <div>
                        Update: {{#if update}}true{{else}}false{{/if}}
                    </div>
                    <div>
                        Only newer: {{#if onlyNewer}}true{{else}}false{{/if}}
                    </div>
                    <div>
                        Throttle: {{throttle}}
                    </div>
                    <div>
                        Resume from: {{resumeFrom}}
                    </div>
                    <div class="status">
                        <div class="statusheader">
                            <strong>Status</strong>
                            <button id="{{id}}" type="button" class="btn btn-default btn-xs">
                                <span class="glyphicon glyphicon-refresh"></span>
                            </button>
                        </div>
                        <div class="clearfix" />
                        <div class="statuscontainer">
                            <div>
                                State: {{status.state}}
                            </div>
                            <div>
                                Current path: {{status.currentPath}}
                            </div>
                            <div>
                                Last saved path: {{status.lastSavedPath}}
                            </div>
                            <div>
                                Total nodes: {{status.totalNodes}}
                            </div>
                            <div>
                                Total size: {{status.totalSize}}
                            </div>
                            <div>
                                Current size: {{status.currentSize}}
                            </div>
                            <div>
                                Current nodes: {{status.currentNodes}}
                            </div>
                        </div>
                    </div>
                </div>
              </div>
            </div>
        </script>

        <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/handlebars.js/2.0.0-alpha.4/handlebars.min.js"></script>
        <script src="/apps/vault-rcp-ui/components/ui/ui.js"></script>
        <!-- Latest compiled and minified JavaScript -->
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    </body>
