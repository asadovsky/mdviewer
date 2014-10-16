(function() {
  'use strict';
  document.body.classList.add('markdown-preview');
  document.body.innerHTML = marked(document.body.innerText);
}());
