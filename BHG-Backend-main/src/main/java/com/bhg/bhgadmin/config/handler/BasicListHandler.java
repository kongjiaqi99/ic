package com.bhg.bhgadmin.config.handler;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.TypeException;

import java.lang.reflect.ParameterizedType;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @author zhangbo
 * @create 2021-11-08 8:50 PM
 */
@MappedJdbcTypes(JdbcType.ARRAY)
public class BasicListHandler<T> extends BaseTypeHandler<List<T>> {
    private static final String TYPE_NAME_VARCHAR = "varchar";
    private static final String TYPE_NAME_INTEGER = "integer";
    private static final String TYPE_NAME_BOOLEAN = "boolean";
    private static final String TYPE_NAME_NUMERIC = "numeric";

    private static final String TYPE_NAME_INT4 = "int4";

    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, List<T> parameter, JdbcType jdbcType) throws SQLException {
        String typeName = null;
        Class clazz = (Class<T>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
        if (clazz == String.class) {
            typeName = TYPE_NAME_VARCHAR;
        }
        if (clazz == Integer.class || clazz == int.class ) {
            typeName = TYPE_NAME_INTEGER;
        }
        if (clazz == Long.class || clazz == long.class ) {
            typeName = TYPE_NAME_INT4;
        }
        if (clazz == Boolean.class || clazz == boolean.class) {
            typeName = TYPE_NAME_BOOLEAN;
        }
        if (clazz == Double.class || clazz == Float.class
                || clazz == double.class || clazz == float.class) {
            typeName = TYPE_NAME_NUMERIC;
        }
        if (typeName == null) {
            throw new TypeException("BasicListHandler parameter typeName error, your type is " + parameter.getClass().getName());
        }
//        pg.setType("int");
//        pg.setValue(parameter.toString());
//        ps.setObject(i, pg);
        Connection conn = ps.getConnection();
        Array array = conn.createArrayOf(typeName, parameter.toArray());
        ps.setArray(i, array);
    }

    @Override
    public List<T> getNullableResult(ResultSet resultSet, String s) throws SQLException {
        return getArray(resultSet.getArray(s));
    }

    @Override
    public List<T> getNullableResult(ResultSet resultSet, int i) throws SQLException {
        return getArray(resultSet.getArray(i));
    }

    @Override
    public List<T> getNullableResult(CallableStatement callableStatement, int i) throws SQLException {
        return getArray(callableStatement.getArray(i));
    }

    private List<T> getArray(Array array) {
        if (array == null) {
            return null;
        }
        try {
            ArrayList<T> res = new ArrayList<>();
            for (Object o : (Object[]) array.getArray()) {
                res.add((T) o);
            }
            return res;
        } catch (Exception e) {
        }
        return null;
    }
}
