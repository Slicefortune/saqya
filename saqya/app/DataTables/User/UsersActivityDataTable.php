<?php

namespace App\DataTables\User;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Builder as QueryBuilder;
use Spatie\Activitylog\Models\Activity;
use Yajra\DataTables\EloquentDataTable;
use Yajra\DataTables\Html\Builder as HtmlBuilder;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Services\DataTable;

class UsersActivityDataTable extends DataTable
{
    /**
     * Build the DataTable class.
     *
     * @param QueryBuilder $query Results from query() method.
     */
    public function dataTable(QueryBuilder $query): EloquentDataTable
    {
        return (new EloquentDataTable($query))
            ->editColumn('created_at', fn (Activity $activity) => Carbon::parse($activity->created_at)->format('Y-m-d H:i a'))
            ->editColumn('subject_type', fn (Activity $record) => preg_replace(
                '/(?<!\ )[A-Z]/',
                ' $0',
                mb_substr($record->subject_type, mb_strrpos($record->subject_type, '\\') + 1)
            ))
            ->addColumn('causer', fn (Activity $activity) => $activity->causer?->name)
            ->setRowId('id');
    }

    /**
     * Get the query source of dataTable.
     */
    public function query(Activity $model): QueryBuilder
    {
        return $model->newQuery()->orderBy('created_at', 'DESC');
    }

    /**
     * Optional method if you want to use the html builder.
     */
    public function html(): HtmlBuilder
    {
        return $this->builder()
            ->setTableId('activity-table')
            ->columns($this->getColumns())
            ->minifiedAjax()
            ->dom('Bfrtip')
            ->selectStyleSingle()
            ->buttons([
                Button::make('excel')->className('btn btn-primary mx-2'),
                Button::make('csv')->className('btn btn-primary mx-2'),
                Button::make('pdf')->className('btn btn-primary'),
                Button::make('print')->className('btn btn-primary mx-2'),
                Button::make('reload')->className('btn btn-primary mx-2')
            ]);
    }

    /**
     * Get the dataTable columns definition.
     */
    public function getColumns(): array
    {
        return [
            Column::make('created_at')
                ->title('Date Time'),
            Column::computed('causer')->className('text-capitalize'),
            Column::make('subject_type')->title('Effected'),
            Column::make('event'),
        ];
    }

    /**
     * Get the filename for export.
     */
    protected function filename(): string
    {
        return 'Activity_' . date('YmdHis');
    }
}
