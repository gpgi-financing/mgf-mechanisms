

document.getElementById("loginButton").onclick = function(){
    let uname = document.getElementById("uname").value;
    let password = document.getElementById("pw").value;
    var xhr = new XMLHttpRequest();
    xhr.open("POST", window.location, true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(JSON.stringify({
        uid: uname,
        pw: password
    }));

}