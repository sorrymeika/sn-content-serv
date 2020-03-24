const { Dao } = require('sonorpc');

const DEFAULT_COLUMNS = ['id', 'userId', 'type', 'status', 'title', 'pictures', 'description', 'content', 'tags', 'praise', 'diss', 'createAt', 'createBy', 'updateAt', 'updateBy'];

class HeadlineDao extends Dao {
    async getHeadlineById(id) {
        const rows = await this.connection.select(DEFAULT_COLUMNS, 'headline', {
            where: {
                id
            }
        });
        return rows[0] || null;
    }

    async getHeadlinesByIds(ids) {
        const rows = await this.connection.select(DEFAULT_COLUMNS, 'headline', {
            where: {
                id: ids
            }
        });
        return rows;
    }

    async queryBlogHeadlines({ blogId, keywords, catalogId, pageNo, pageSize }) {
        let where = 'b.blogId=?';
        let query = [blogId];

        if (keywords) {
            where += ' and (a.title like ? and a.tags like ?)';
            query.push('%' + keywords + '%', '%' + keywords + '%');
        }

        if (catalogId) {
            where += ' and b.catalogId=?';
            query.push(catalogId);
        }

        const rows = await this.connection.query(
            `select 
                a.id,a.userId,a.type,a.status,a.title,a.pictures,a.description,a.tags,a.praise,a.diss,a.createAt,a.createBy,a.updateAt,a.updateBy,
                b.catalogId,b.blogId
            from headline a
            join blogHeadlineRel b on a.id=b.headlineId
                where ${where} limit ${(pageNo - 1) * pageSize},${pageSize}`,
            query
        );
        return rows;
    }
}

module.exports = HeadlineDao;