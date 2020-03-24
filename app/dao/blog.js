const { Dao } = require('sonorpc');

const DEFAULT_COLUMNS = ['id', 'name', 'description', 'userId', 'headerImg', 'status', 'createAt'];

class BlogDao extends Dao {
    async getBlogByUserId(userId) {
        const rows = await this.connection.select(DEFAULT_COLUMNS, 'blog', {
            where: {
                userId
            }
        });
        return rows[0] || null;
    }

    async getBlogById(blogId) {
        const rows = await this.connection.select(DEFAULT_COLUMNS, 'blog', {
            where: {
                id: blogId
            }
        });
        return rows[0] || null;
    }

    async addBlog({ name, description, userId, headerImg }) {
        const res = await this.connection.insert('blog', {
            name,
            description,
            userId,
            headerImg
        });
        return { id: res.insertId };
    }

    updateBlog({ blogId, description, headerImg }) {
        return this.connection.update('blog', {
            description,
            headerImg
        }, {
            id: blogId
        });
    }
}

module.exports = BlogDao;