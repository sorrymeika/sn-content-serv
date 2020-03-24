const { Service } = require('sonorpc');

class BlogService extends Service {
    getBlogByUserId(userId) {
        return this.app.dao.blog.getBlogByUserId(userId);
    }

    getBlogById(id) {
        return this.app.dao.blog.getBlogById(id);
    }

    addBlog(data) {
        return this.app.dao.blog.addBlog(data);
    }

    updateBlog(data) {
        return this.app.dao.blog.updateBlog(data);
    }
}

module.exports = BlogService;