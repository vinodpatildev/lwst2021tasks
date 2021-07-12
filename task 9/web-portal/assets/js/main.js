var cmd = "";
var host = "";


(function() {
  "use strict";

  
  const select = (el, all = false) => {
    el = el.trim()
    if (all) {
      return [...document.querySelectorAll(el)]
    } else {
      return document.querySelector(el)
    }
  }

  
  const on = (type, el, listener, all = false) => {
    let selectEl = select(el, all)
    if (selectEl) {
      if (all) {
        selectEl.forEach(e => e.addEventListener(type, listener))
      } else {
        selectEl.addEventListener(type, listener)
      }
    }
  }

  
  const onscroll = (el, listener) => {
    el.addEventListener('scroll', listener)
  }

  
  let backtotop = select('.back-to-top')
  if (backtotop) {
    const toggleBacktotop = () => {
      if (window.scrollY > 100) {
        backtotop.classList.add('active')
      } else {
        backtotop.classList.remove('active')
      }
    }
    window.addEventListener('load', toggleBacktotop)
    onscroll(document, toggleBacktotop)
  }

  
  let countdown = select('.countdown');
  const output = countdown.innerHTML;

  const countDownDate = function() {
    let timeleft = new Date(countdown.getAttribute('data-count')).getTime() - new Date().getTime();

    let days = Math.floor(timeleft / (1000 * 60 * 60 * 24));
    let hours = Math.floor((timeleft % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    let minutes = Math.floor((timeleft % (1000 * 60 * 60)) / (1000 * 60));
    let seconds = Math.floor((timeleft % (1000 * 60)) / 1000);

    countdown.innerHTML = output.replace('%d', days).replace('%h', hours).replace('%m', minutes).replace('%s', seconds);
  }
  countDownDate();
  setInterval(countDownDate, 1000);

})()

function run()
{
	var xhr = new XMLHttpRequest();
	console.log(cmd);
	xhr.open("GET", `http://${host}/cgi-bin/k8s.py?command=${cmd}`, true);
	xhr.send();

	xhr.onload = function() {
			            var output = xhr.responseText;
			            document.getElementById("result").innerHTML = output;
			        }
       cmd = "";
}


function task()
{
var task = document.getElementById("command").value;
if (task.includes("delete")){
  var rs_type = prompt("Enter the Resource Type or All:- ");
  if (rs_type.includes("all")){
    cmd = `sudo kubectl delete all --all --kubeconfig admin.conf`;
    }
  else{
//    var rs_type = prompt("Enter the Resource Type:- ");
    var rs_name = prompt("Enter the Resource Name:- ");
    cmd = `sudo kubectl delete ${rs_type} ${rs_name} --kubeconfig admin.conf`;
    }
}
else if (task.includes("expose")  || task.includes("service") ){
  if (task.includes("deployment")){
    var dep_name = prompt("Enter the Deployment Name:- ");
    var port = prompt("Enter the Port Number of Pod to be exposed:- ");
    var type = prompt("Enter the service type:- ");
    cmd = `sudo kubectl expose deployment ${dep_name} --port=${port} --type=${type} --kubeconfig admin.conf`;
    }
  else if (task.includes("pod")){
    var os_name = prompt("Enter the Pod Name:- ");
    var port = prompt("Enter the Port Number of Pod to be exposed:- ");
    var type = prompt("Enter the service type:- ");
    cmd = `sudo kubectl expose pod ${os_name} --port=${port} --type=${type} --kubeconfig admin.conf`;
    }
 else if (task.includes("show")){
    cmd = `sudo kubectl get svc --kubeconfig admin.conf`;
    }
}
else if (task.includes("pod")){
  if (task.includes("launch") || task.includes("run") || task.includes("create")){
    var img_name = prompt("Enter the Image Name:- ");
    var os_name = prompt("Enter the Pod Name:- ");
    cmd = `sudo kubectl run ${os_name} --image=${img_name} --kubeconfig admin.conf`;
    }
  else if (task.includes("view") || task.includes("details") || task.includes("get") || task.includes("show")){
    cmd = `sudo kubectl get pods --kubeconfig admin.conf`;
    }
}
else if (task.includes("deployment")){
  if (task.includes("launch") || task.includes("run") || task.includes("create")){
    var img_name = prompt("Enter the Image Name:- ");
    var dep_name = prompt("Enter the Deployment Name:- ");
    cmd = `sudo kubectl create deployment ${dep_name} --image=${img_name} --kubeconfig admin.conf`;
    }
  else if (task.includes("view") || task.includes("details") || task.includes("get")  || task.includes("show")){
    cmd = `sudo kubectl get deployment --kubeconfig admin.conf`;
    }
}
else if (task.includes("replica") || task.includes("scale")){
  var dep_name = prompt("Enter the Deployment Name:- ");
  var replicas = prompt("Enter the Number of Replicas:- ");
  cmd = `sudo kubectl scale deployment ${dep_name} --replicas=${replicas} --kubeconfig admin.conf`;
    }
else if (task.includes("node") || task.includes("show")){
  cmd = `sudo kubectl get node --kubeconfig admin.conf`;
    }
}
