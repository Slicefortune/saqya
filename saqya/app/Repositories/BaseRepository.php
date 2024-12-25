<?php

declare(strict_types=1);

namespace App\Repositories;

use App\Interfaces\Repositories\IBaseRepository;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

class BaseRepository implements IBaseRepository
{
    public Model $model;

    /**
     * Constructor
     */
    public function __construct(Model $model)
    {
        $this->model = $model;
    }

    /**
     * Return all data
     */
    public function all(array $relations = []): Collection
    {
        return $this->model->query()->with($relations)->get();
    }

    /**
     * Return all the data in descending order
     */
    public function latest(array $relations = []): Collection
    {
        return $this->model->query()->with($relations)->latest()->get();
    }

    /**
     * Create new record
     */
    public function create(array $data): Model
    {
        return $this->model->query()->create($data);
    }

    /**
     * Find record based on primary key
     */
    public function findOrFail(int $id, array $relations = []): Model
    {
        return $this->model->query()->with($relations)->findOrFail($id);
    }

    /**
     * Find all records matching conditions
     */
    public function allWhere(array $conditions, array $relations = []): Collection
    {
        return $this->model->query()->with($relations)->where($conditions)->get();
    }

    /**
     * Find first record matching conditions
     */
    public function firstWhere(array $conditions, array $relations = []): ?Model
    {
        return $this->model->query()->with($relations)->where($conditions)->first();
    }

    /**
     * Update record
     */
    public function update(int $id, array $data): ?Model
    {
        $model = $this->model->query()->findOrFail($id);
        $model->update($data);

        return $model;
    }

    /**
     * Delete record
     */
    public function delete(int $id): bool
    {
        return $this->model->query()->findOrFail($id)->delete();
    }

    /**
     * Get All Records paginated
     */
    public function paginate(int $paginate, array $conditions, array $relations = []): LengthAwarePaginator
    {
        return $this->model->query()->with($relations)->where($conditions)->paginate($paginate);
    }

    /**
     * Return all records order by based on conditions
     */
    public function orderBy(string $column, string $order): Collection|array
    {
        return $this->model->query()->orderBy($column, $order)->get();
    }

    /**
     * Find all records matching conditions
     */
    public function whereIn(string $column, array $values, array $relations = []): Collection
    {
        return $this->model->query()->with($relations)->whereIn($column, $values)->get();
    }
}
