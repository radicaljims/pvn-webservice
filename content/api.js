
function getusers(onSuccess, onError)
{
  $.ajax(
    { url: '/users'
    , success: onSuccess
    , error: onError
    , type: 'GET'
    });
}

function getusers(name, onSuccess, onError)
{
  $.ajax(
    { url: '/users/' + encodeURIComponent(name) + ''
    , success: onSuccess
    , error: onError
    , type: 'GET'
    });
}

function postusers(body, onSuccess, onError)
{
  $.ajax(
    { url: '/users'
    , success: onSuccess
    , data: JSON.stringify(body)
    , contentType: 'application/json'
    , error: onError
    , type: 'POST'
    });
}
