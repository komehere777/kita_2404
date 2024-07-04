{/* <script> */}
      document.addEventListener("DOMContentLoaded", function () {
        fetch("/tasks")
          .then((response) => response.json())
          .then((tasks) => {
            const taskList = document.getElementById("task-list");
            tasks.forEach((task) => {
              const li = document.createElement("li");
              li.innerHTML = `<div id="list_card"><div class="list_title"><strong>${task.title}</strong></div>
                                    <div id="list_card_contents">${task.contents}<br><br><br><br></div>
                                    <div class="list_date">등록일: ${task.input_date}<br>
                                    마감일: ${task.due_date}</div></div>`;

              const editLink = document.createElement("a");
              editLink.href = `/edit/${task.id}`;
              editLink.textContent = "Edit";
              editLink.innerHTML = `<button style="float: right;" class="btn btn-primary">Edit</button>`;
              

              const deleteLink = document.createElement("a");
              deleteLink.href = `/delete/${task.id}`;
              deleteLink.textContent = "Delete";
              deleteLink.innerHTML = `<button style="float: right;" class="btn btn-danger">Delete</button>`;
              li.appendChild(deleteLink);
              li.appendChild(editLink);

              taskList.appendChild(li);
            });
          });
      });
    // </script>