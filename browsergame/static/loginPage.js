

document.getElementById("loginButton").onclick = function(){
    let uname = document.getElementById("uname").value;
    let password = document.getElementById("pw").value;
    let json = {
        "uid": uname,
        "pw": password
    }
    const options = {
        method: 'POST',
        body: JSON.stringify(json),
        headers: {
            "Content-Type": "application/json"
        }
    }
    fetch(window.location, options)
    .then(res => res.json())
    .then(res => console.log(res))
    .catch(err => console.error(err));
}