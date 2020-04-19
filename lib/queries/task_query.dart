const String GET_TASKS_QUERY = r'''
  query getTasks($search: String, $status: TaskStatus, $skip: Int, $limit: Int) { 
    getTasks(search: $search, status: $status, skip: $skip, limit: $limit) {
      __typename
      id
      title
      description
      status
    }
  }
''';

const String UPDATE_TASK_STATUS_QUERY = r'''
  mutation ($id: ID!, $status: TaskStatus!) { 
    updateTaskStatus(id: $id, status: $status) {
      __typename
      id
      title
      description
      status
    }
  }
''';

const String DELETE_TASK_BY_ID = r'''
  mutation ($id: ID!) { 
    deleteTask(id: $id) {
      __typename
      id
      title
      description
      status
    }
  }
''';

const String CREATE_TASK = r'''
  mutation ($title: String!, $description: String!) { 
    createTask(title: $title, description: $description) {
      __typename
      id
      title
      description
      status
    }
  }
''';
