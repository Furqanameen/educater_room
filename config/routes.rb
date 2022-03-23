require 'subdomain_constraint'
require 'domain_constraint'

Rails.application.routes.draw do
  constraints DomainConstraint do
    root 'pages#home'

    resources :pages, only: [], path: '/' do
      collection do
        get :home
        get :about_us,                   path: 'about-us'
        get :terms_and_conditions,       path: 'terms-and-conditions'
        get :frequently_asked_questions, path: 'frequently-asked-questions'
        get :student_overview,           path: 'student-overview'
        get :instructor_overview,        path: 'instructor-overview'
        get :organization_overview,      path: 'organization-overview'
        get :privacy_and_policy,         path: 'privacy-and-policy'
        get :error_404,                  path: 'error-404'
        get :error_422,                  path: 'error-422'
        get :error_500,                  path: 'error-500'
      end
    end

    resources :organizations, only: %i[new create]

    namespace :admin do
      resources :dashboard, only: %i[index]
      resources :users
      resources :payment_plans, only: %i[index new create]
    end
  end

  constraints SubdomainConstraint do
    root 'org_public/home#index'

    devise_for :users, controllers: {
      sessions: 'users/sessions',
      passwords: 'users/passwords',
      registrations: 'users/registrations'
    }

    namespace :org_public, path: '/' do
      resources :home, only: %i[index], path: '/'
    end

    namespace :instructor do
      resources :dashboard, only: %i[index]
      resources :course_sections, path: 'courses', only: %i[index] do
        resources :lessons do
          delete :restore, on: :member
          post   :load_media, on: :collection
        end
        resources :quizzes
        resources :assignments do
          delete :restore, on: :member
        end
      end
      resources :earnings, only: [:index] do
        collection do
          get :payout
          get :profile
        end
      end
      resources :profiles, only: %i[show edit update]
    end

    namespace :student do
      resources :dashboard, only: [:index]
      resources :courses, only: [:index, :getting_started, :take_course] do
        collection do
          get :series
          get :getting_started
          get :take_course
          get :take_quiz
          get :billing
          get :edit_account
          get :student_profile
        end
      end
      resources :course_sections, only: [:index] do
        resources :quizzes, only: [:index, :show]
      end
      post :submit_answer, to: "quizzes#submit_answer"
      get  :skip_question, to: "quizzes#skip_question"
    end

    namespace :organisation do
      resources :dashboard, only: [:index]
      resources :batches do
        delete :restore, on: :member
      end
      resources :sections do
        get    :enroll_students_modal, on: :collection
        post   :enroll_students, on: :collection
        delete :restore, on: :member
      end
      resources :courses do
        delete :restore, on: :member
      end
      resources :instructors do
        delete :restore, on: :member
      end
      resources :students do
        delete :restore, on: :member
      end
      resources :billings, only: [:index] do
        get :instructor_salaries, on: :collection
        get :student_fees,        on: :collection
        get :student_dashboard,   on: :collection
        get :payment_details,     on: :collection
      end
      resources :payment_plans, only: [:index] do
        get :payment_history, on: :collection
        get :details, on: :collection
      end
      resources :profiles, only: %i[index edit update]
    end

  end
end
