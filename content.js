(function() {
  'use strict';
  var el = document.createElement('div');
  el.classList.add('markdown-body');
  el.innerHTML = marked(document.body.innerText);
  document.body.innerHTML = '';
  document.body.appendChild(el);
}());
