<?php

namespace App\Repositories;

class EloquentRepository extends BaseRepository
{
    /**
     * Return all model rows
     * @param array $columns
     * @param string $orderBy
     * @param string $sortBy
     * @return mixed
     */
    public function all($columns = array('*'), string $orderBy = 'id', string $sortBy = 'desc')
    {
        return $this->model->orderBy($orderBy, $sortBy)->get($columns);
    }

    /**
     * Create a model instance
     * @param array $attributes
     * @return mixed
     */
    public function create(array $attributes)
    {
        return $this->model->create($attributes);
    }

    /**
     * Create a model instance or return if it already exists
     * @param array $attributes
     * @return mixed
     */
    public function firstOrCreate(array $attributes)
    {
        return $this->model->firstOrCreate($attributes);
    }

    /**
     * Update a model instance
     * @param array $attributes
     * @param int $id
     * @return mixed
     */
    public function update(array $attributes, int $id)
    {
        $model = $this->findOneOrFail($id);
        return $model->update($attributes);
    }

    /**
     * Find one by ID
     * @param int $id
     * @return mixed
     */
    public function find(int $id)
    {
        return $this->model->find($id);
    }

    /**
     * Find one by ID or throw exception
     * @param int $id
     * @return mixed
     */
    public function findOneOrFail(int $id)
    {
        return $this->model->findOrFail($id);
    }

    /**
     * Find based on a different column
     * @param array $data
     * @return mixed
     */
    public function findBy(array $data)
    {
        $query = $this->model->query();
        foreach ($data as $key => $value) {
            $query = $query->where($key, $value);
        }
        return $query;
    }

    /**
     * Delete one by Id
     * @param int $id
     * @return mixed
     */
    public function delete(int $id)
    {
        $model = $this->findOneOrFail($id);
        return $model->delete();
    }
}
